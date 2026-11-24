Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546442;
	b=3CzK9H8zym3n+gD2F3vPx+reKvk3HBCJWicWa3DpLmPlMHWcYeVnkzy1EnuPR9dSkS8c
	 lKPdBL784hT/3m3Lh5yMDFcqHY5uVI7OEtMsPJX7gfkVrV8ptBe9xzY8otK0Nk3Lm8WGS
	 7VzdGYZQcu6COH9qSFGBxG85bWkOauAfbaw5QaBzF7v7OvaNH7i5koIBUp3kjroFKB8AO
	 hQyj9leTyNrFI/pSxbuqI74LVE0aiSRhzO+AIUpUQhds7Q7lrO3Fz5EPXFs9xC6TWy6/O
	 HNa/qARZoH2buRsEOZpEST3ivP/zhphHbM+7zxgHSGA/FeLNernGMIDidIFZ3QoFa0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546442;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6dOlIFyIREpYmlEbD+Zu74jIiaQeq22rCtJOqQModUg=;
	b=Cd/gB7/463/Y+4DZ7PpRMKfWmXWlQQboVsytPyxsjnMKzGmA05FNvcl+RUO6gyXPGaKn
	 huA05QUcY6R8VBlULZVlBxIRv1DQVhX8l7jWeJSmRV7AH5/crQVbFUdiBmu5TN9aA/vWV
	 z+LOhpQGA8U2Zhu5FwqNo4a1KcDT5EQUgGLrdVu9RyE02g/KZT5cGldRZgsT1hAv+0r7M
	 tPV7mmUMoTfTDpAh58sniZhhKpOfwELxV6dYdkDKfbSJipPqNe4BCNxOiRUmbJ8KPGbt1
	 lr+fnd+g/Zr1FHMK3yws5B4UqlUwHMDFApV2haphONPcf2gqiB4JN4a/xJE4vs0ynsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BjRfFW17;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AEE606A31E
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 18:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BjRfFW17
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F2B1F000C0;
	Tue, 24 Nov 2026 18:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795546442;
	bh=6dOlIFyIREpYmlEbD+Zu74jIiaQeq22rCtJOqQModUg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BjRfFW17U+6528A/uG52nOPGX+XAN3B0m2iI9pfj19/41leBnc5lfnfnrdfmz/G3D
	 +IJnN04kdMIKmtRSd42opFfW/uC6rD1yZHgmOr5hrJPFzmx7QMQ4wZ4kbJY5adG9zl
	 Vv06yEc+hkWDOENnICfAa9iiauf6c1vE8lq+wKlQi/52+P+WsPpqOy9ay6AtYR/OPU
	 bTEjn/r5YXsrHjLp0uju6mf4BvD2SYUsP1klPaB3rfOQL7TMmK0q2kcpIWli++RL5U
	 hWvQ9fSVvZJlPIQDVPnKOPF80TwAFzRtxP7NcTSUoHj33ODDoocp6E98I0SBoHnpm3
	 AajjvGMvcj3/w==
Message-ID: <sashiko-outbox-231861@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 05/17] perf tests script: Exercise the list, fields
 and dump options
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261124184604.24983-6-acme@kernel.org>
References: <20261124184604.24983-1-acme@kernel.org>
 <20261124184604.24983-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 18:54:01 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] perf tests script: disasm in test_script_fields() fails
  without libcapstone
--

commit 11f72d07cda14b3cc3bb37ec5610a17a52bfd7b5
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tests script: Exercise the list, fields and dump options

This commit expands the perf script shell test to exercise script listing,
output field selection, per-event dumps, header output, task and mmap
events, and miscellaneous display options.

> diff --git a/tools/perf/tests/shell/script.sh b/tools/perf/tests/shell/sc=
ript.sh
> index af687c7cfe44c..a74d45d51ae47 100755
> --- a/tools/perf/tests/shell/script.sh
> +++ b/tools/perf/tests/shell/script.sh

[ ... ]

> @@ -27,18 +43,123 @@ trap_cleanup()
> =20
>  trap trap_cleanup EXIT TERM INT
> =20
> +script_data=3D"${temp_dir}/script-perf.data"

[ ... ]

> +test_script_fields()
> +{
> +	echo "perf script fields test"
> +	perf record -o "${script_data}" -e cpu-clock --sample-cpu ${testprog}
> +	if ! perf script -i "${script_data}" -F comm,tid,pid,time,cpu,event,ip,=
sym,dso,dsoff,symoff,period,machine_pid,vcpu,ipc,insn,insnlen,disasm,misc,m=
etric,synth,callindent,flags | grep -q "${testsym}"
> +	then
> +		echo "perf script fields test [Failed missing ${testsym}]"
> +		err=3D1
> +		return
> +	fi

[Severity: Medium]
Does test_script_fields() fail when perf is built without libcapstone
support?

In tools/perf/builtin-script.c, parse_output_fields() rejects -F disasm
with -EINVAL unless HAVE_LIBCAPSTONE_SUPPORT is defined, which causes
perf script to exit without output, sets err=3D1, and returns early before
the +cpu and -comm checks run.  Guarding the disasm field with
"perf check feature -q libcapstone" would avoid failing on builds
without capstone.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124184604.2498=
3-1-acme@kernel.org?part=3D5
