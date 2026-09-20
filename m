Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BB9345ED9
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882533; cv=none; b=XQNswnSAKGyCtUdxGiPbJQ0sOJQiLLpAnRHYuF98yJ0H6wpg5JT8fblCvCTNLu3VuslqnqxQvQ3DHekcLSxFIS4/437BuJuD74VG2aZm51+dQEHbUEogmjp3NXQNzbgEAc257CSG3f51p/+VSLYqs1pqdz4xQnsLNANHqabqybg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882533; c=relaxed/simple;
	bh=moixBrRlINkMabVzQM+Jx4CdRzX6oSN36YLSd/rI/vw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fy8ybNbWsKbKiJZIQDnTmL6rb/AIN2+AtxOUJlYUo94QOMRGa2lchvIqvFXgPsUC5/038SrD1HlCW36fpVaWS7Ald9HxhB0HUbTgx6m2562a5IeSX/iC+/6ZNNABS3XYlq/MHqqryw88QvQIBbHYFcjw0VET709wbpMfd22n5+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4h3PxxT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4h3PxxT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94DA1F000FF;
	Sun, 20 Sep 2026 05:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789882532;
	bh=fYZyLGsa/g+lZpUa1WwWRFq4fhNLAgw8SF8Mkyt0c6s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E4h3PxxTqtw0dEDH0hSGRY16F1W8DVgJjbujJ1i6EaEO58fIpZ5BT7YiaGdqvsBDC
	 RWJT2X7j+Xtjx8MY/Z+fGL1A0+2STKgxca7Igq9Weou/1CIgsQ4/plHd2T64ZzXHcC
	 0Wy+iLjf7xMzTXsIu16F5t/I+erZNvxpooT/pqJr3uEZEX8jzz6A3UxMMymu/ud15e
	 bKIEesGaDl/BR9fSjKPTwSSo8tke/H1F52YdYBKr4mpR7JZL/W1FhIe+FgFXbl+UAo
	 T6p7S7yZTq1DoV5oldNzz6QRQ9FUFv9D1IV8uLy84H6Q0c9XZr1tPBzy3LUuZyg4dr
	 V06dKhDVe2/BQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 09/49] perf python: Add Intel PT call_return and
 itrace capability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <8b402b477b6c75008a472bc03f17635fbb1d2db0.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <8b402b477b6c75008a472bc03f17635fbb1d2db0.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:35:31 +0000
Message-Id: <20260920053531.E94DA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add support for Intel PT call_return events and itrace options to the
> perf Python extension so standalone Python scripts can decode and
> inspect low-level instruction traces.
>=20
> Specifically:
> - Add a call_return callback parameter and itrace option string to
>   perf.session, treating explicit None (Py_None) callbacks as omitted.
> - Expose the perf.call_return object with db_id, parent_id, insn_count,
>   cyc_count, comm, pid, tid, call_time, return_time, branch_count,
>   call_ref, return_ref, flags, and call_path (resolved as a
>   perf.callchain ordered from outermost caller to callee).
> - Export perf.CALL_RETURN_NO_CALL, perf.CALL_RETURN_NO_RETURN, and
>   perf.CALL_RETURN_NON_CALL flag constants.
> - Expose session.e_machine and session.is_64_bit properties, preferring
>   recorded thread ELF machines (perf_session__e_machine) over perf_env
>   so pipe-mode traces do not prematurely cache host bitness.
> - Support optional vmlinux, kallsyms, and symfs symbol configuration
>   parameters (and PERF_SYMBOL_VMLINUX, PERF_SYMBOL_KALLSYMS,
>   PERF_SYMBOL_SYMFS environment fallbacks) in perf.session, resetting
>     symbol_conf pointers and freeing vm_tm_corr_args, cpu_bitmap, and
>   ptime_range in
>   pyrf_session__delete().
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D9

