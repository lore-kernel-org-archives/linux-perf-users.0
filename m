Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792508725;
	b=AnO/ukp38DKgkAhH0YUBjRRlxFTSyFI+GJ4OuSqY64IkgimlgEvoApZFxG9ih6+KC5q0
	 dv21YUHYnoSwhFgWWtKPDXujoMNF+4FxyOfWtWal7QVJLJpzMEoD0hTR8kSuO7z+t4UVA
	 l+1KTFT5JVb61ZUORMqoJQ6ikQxUfLPacxL2guBN0bydkxNePDY/GwTdRhNj5qiVl9clA
	 5IwChFGxohonSm1QgwnGQu5HpWASG1m7CwFRASQNY/iRv1XRzjDn/1qYa+M+NrHGILdV4
	 /UuGrC/k6/RMxNwRD57xDTTox857aZxjRjD7GoXi5iRNCe6g+4e2FwuNNoj1GbUtWcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792508725;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=U2uG/a+EfbVEndAoRi6GcqpdU86qsAmne35qf9v5TOU=;
	b=M2sCo/f0gQ3aY88tTy0fibWNnqTb7pp0yq4kWMGsFhyvKUVwU9/SVWp+KG0ygcUpXZNM
	 LBUE2XgG3ENqjmRRYFYKsuUYOqD0Zno77N+bmTKozNJ4ok1aNOPJjujhksrsJPt1mo6FI
	 /racnD9Y9QbEu8yC36gcICI2LX3DJHlIca76UgrRC0UAbnzaUF9Y1QZ7vZq8Sexdsz1Sl
	 tkFW30oMEZcpFr+dSeL9AjuSTST5SqzhPW1+vq/Ef9HVakdsP1/uZTi/o0w/t01og1ylH
	 qgdvXt49ZpVC8jIiYt0/0fEstfOX1Fz8x6cOjKHTZjnvZrBcGBbs8ALX0PgBv44p39w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jnWEf9i8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A50606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 15:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jnWEf9i8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278A11F000C4;
	Tue, 20 Oct 2026 15:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792508724;
	bh=U2uG/a+EfbVEndAoRi6GcqpdU86qsAmne35qf9v5TOU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jnWEf9i8rKm+y90k+22QPcXzomlEVyLzcR/hYNJGpgfA8+dFkKkZEaLXqsfzPps6/
	 OQlsfQ6r3GCV48tPVUFvos73EPUNg80UZ3Kp+dZ/My7ONoDTU4PWbTcQEOEz2YLs8Y
	 uNCOeJVvtCo61jKJG9ZkXcWEmdX4YqUkdpFt2gPmKWrOue5n0jt8l/YAwJexJkeaOy
	 f9w07Rsnirw5jwc6jku/eifMjP2xzZSMh5t2VcvkTThad3moo/d9XU6bsalYo+ekeA
	 UN01MpYyNNewq1JIK0/Ng7XBSy+aekghzuZA3ovGjnNIak6THPlYbFKKm3Y89hXMB5
	 YirJ01l9aJamg==
Message-ID: <sashiko-outbox-179224@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 12/15] perf annotate-arm64: Support 'add' instruction
 tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <adbd0606147f0243bfe059002d97703a25e153a5.1792411435.git.wutengda@huaweicloud.com>
References: <cover.1792411435.git.wutengda@huaweicloud.com>
 <adbd0606147f0243bfe059002d97703a25e153a5.1792411435.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 15:05:23 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Extend update_insn_state_arm64() to track 'add' instructions for
> structure member address calculation.
>=20
> Unlike x86, the arm64 'add' instruction has an extra base register among
> its source operands. Therefore, in terms of propagating the data type,
> it is essentially performing a 'mov', except that before the 'mov', it
> first needs to be updated by adding the offset or reg2.
>=20
> A real-world example is shown below:
>=20
>   ffff80008001c9a8 <flush_ptrace_hw_breakpoint>:
>   ffff80008001c9c4:  add  x19, x0, #0xeb8   // x0 (task_struct*) + 0xeb8 =
-> x19
> * ffff80008001c9d0:  ldr  x0, [x19]
>=20
> Before this commit, the type flow broke at the 'add' instruction,
> [ ... ]
>   final result: type=3D'struct task_struct'
>=20
> Reviewed-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792411435.gi=
t.wutengda@huaweicloud.com?part=3D12

