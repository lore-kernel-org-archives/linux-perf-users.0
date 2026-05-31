Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D074C30DEBE
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 08:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780216450; cv=none; b=k4MhhUuo3i366kai6R1dGB4zZogxKiXrbXZ1vPJfKVT22C554NLQcp3WHjT/+8GYodQ7USSqunG/2EMJXXNwquUxo7j+2YXdcZKfqQmJabF/KXYDZYni4zPF09309bmt071h6x5CRIFu33zpa0v39MbzdrjWWZz4uGR2eV1A+rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780216450; c=relaxed/simple;
	bh=g9efSNDQuH6nkSEV38tFpcWnk1JC618bo/ooIAEI9rE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i3R6opOB3pWninwCGrkQuKbXBngwtQcFJL+rghzjX9n/xBcVeG7tysJY8e3LJ7caDTlK6uBO/aVWaWQct6TK/5fUIHA5D90TA9E7LTtvUHLZvpj1S8h0+4j+38dUsDmvFeZTbqZaFcoP1aMQ5KF6Gle3twaxQjXqMUJ9gq5Ha0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tj2IKtMS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tj2IKtMS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C92F1F00893;
	Sun, 31 May 2026 08:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780216449;
	bh=t3colaUx9DMTR/b66hzjP3pqk6S7akhyRop5+2BEOGM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Tj2IKtMSwgVeSJdPHZWYvs75HJtF15mfewKDsR0OPmIPROqQ/qSyoEM2IoFbBz4Jj
	 lSuAmgt/LWwm/UhlYCbQKW57u8SViS7JTTG+2ETHM1DE2KRf5/W8vDsjkBRUCepaiB
	 CK+bCAyqKbesQZ4G1SclqNnQ1zrpG3J1PQCs6GQIkv4EvwDa/K5/NhONT6dWXbjVpC
	 PETn3TY6aoVZ6w9U+ldstzCvK1E2LYGEd+4aeGlTez8ILM6fA3DqtzkajSwH6CP9Cd
	 nn2bINEccVGZtKqG57x+292wHMjqg9VLDbfoXa6XffsPpZfZp1lbnWlqigqE3uGEHf
	 BaSWrP/RydHwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/15] perf test: Refactor parallel poll loop to
 drain all pipes simultaneously
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260531082235.940833-8-irogers@google.com>
References: <20260531082235.940833-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 08:34:08 +0000
Message-Id: <20260531083409.6C92F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] A double-free vulnerability exists on `global_pfds` and `global_=
pfd_indices` if an asynchronous signal (e.g., SIGINT) interrupts the execut=
ion of `finish_tests_parallel()`.
- [Medium] If the test harness is interrupted by a signal, any stderr outpu=
t already accumulated for running tests is silently dropped and never print=
ed.
--

commit 9b2b54f1cd46342d54f3ddb09c0ae143f4fd7d36
Author: Ian Rogers <irogers@google.com>

perf test: Refactor parallel poll loop to drain all pipes simultaneously

When running tests in parallel with verbose output, child processes fill up
pipe buffers and block. This patch implements finish_tests_parallel() to
poll and drain all pipes simultaneously, avoiding the block and drastically
speeding up parallel testing.

> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index 2ccb52a776ccb..9f71f11928c60 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
[ ... ]
> @@ -503,12 +509,205 @@ static void finish_test(struct child_test **child_=
tests, int running_test, int c
>  		fprintf(stderr, "%s", err_output.buf);
> =20
>  	strbuf_release(&err_output);
> +	strbuf_release(&child_test->err_output);

[Severity: Medium]
If a signal arrives during finish_tests_parallel() and triggers the signal
handler's siglongjmp to err_out, finish_test() is called to clean up.

At this point, finish_tests_parallel() may have already drained some of the
child's stderr into child_test->err_output. Because finish_test() drains
any remaining output into its local err_output buffer and prints that, will
the previously accumulated data in child_test->err_output be silently
released and lost here?

>  	print_test_result(t, curr_suite, curr_test_case, ret, width, /*running=
=3D*/0);
>  	if (err > 0)
>  		close(err);
>  	zfree(&child_tests[running_test]);
>  }
[ ... ]
> +static int finish_tests_parallel(struct child_test **child_tests, size_t=
 num_tests, int width)
> +{
[ ... ]
> +		for (i =3D next_to_print; i < num_tests; i++) {
> +			struct child_test *child =3D child_tests[i];
[ ... ]
> +			print_test_result(child->test, child->suite_num, child->test_case_num,
> +					  child->result, width, 0);
> +			strbuf_release(&child->err_output);
> +			child_tests[next_to_print] =3D NULL;
> +			zfree(&child);
> +			next_to_print++;
> +		}
> +	}
> +
> +	free(global_pfds);
> +	free(global_pfd_indices);
> +	global_pfds =3D NULL;
> +	global_pfd_indices =3D NULL;

[Severity: Medium]
Can this sequence trigger a double free if a signal interrupts execution?

If a signal (like SIGINT) is caught immediately after free(global_pfds)
but before global_pfds =3D NULL, the signal handler invokes siglongjmp
and jumps to err_out in __cmd_test().

The err_out cleanup block unconditionally calls free(global_pfds) again,
which would lead to a double-free since the pointer hasn't been set to
NULL yet.

> +	return 0;
> +}
[ ... ]
> @@ -683,6 +883,10 @@ static int __cmd_test(struct test_suite **suites, in=
t argc, const char *argv[],
>  		for (size_t x =3D 0; x < num_tests; x++)
>  			finish_test(child_tests, x, num_tests, width);
>  	}
> +	free(global_pfds);
> +	free(global_pfd_indices);
> +	global_pfds =3D NULL;
> +	global_pfd_indices =3D NULL;
>  	free(child_tests);
>  	return err;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531082235.9408=
33-1-irogers@google.com?part=3D7
