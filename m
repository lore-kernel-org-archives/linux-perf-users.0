Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795547009;
	b=5P567qbGrwrvtb/Gb1nwZ86lPlbkZ7kIV4kt/PYqP+OSHeX/BzsRmMjQ1ynBkHCXIuV+
	 OJqjL0XVTiB87XoFG+XIi9sHIhUqaYQ3OyZq7bMDCegNcCRKH05jL7VSau1qZtRLhXs+o
	 9ijtrO3J0qjJ6u5qxDOznYpYh/pEkavLMAed5qU2ttQDDENYHBLXAiMdMNlcuD2tmK0Jv
	 cbPKOxpzfYav5zITzx2aUiyx5tzgBsSGbeIVRbckaomFBMKOjHjyIIQvbS0GkAcjWl/ff
	 haPXZ6v6QCaY2s0Gs+2/AKpZNBYqKsvRQN7eROc2O6nNwaQHRq7mbSZSTxE0wWN6o5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795547009;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hnJQ3SAGbAenoJqr6pKm7sS8tAraWbdlvOd3SGc6cO4=;
	b=X51GIbfNpp5qvG/jipi1jlUvIRYDx/NfqaI5FuygvGheK4ti/ebzWO3RbOr0supakCcT
	 BLHNNOu7kmFhNWJBamJpsQG4e8JB3pAyKPzRMG/R8mTfnp0UbMSGT4w5J+MoHxqegIQsI
	 zt/jPs66ir9SS6/1HRCgN3SW+Q6RoKw6KKtrK6vOFvatuLBgUTdRE7NbGLze6Mou9c1/+
	 XOm0pgYm3Hz1yHyuj0PPIaizTEs4+pgEjrIwvSzYlvM4VVyrUTPYPDJNy+IpfhYj7FWN/
	 MAEKNgRyW9U1UM3ibV3hetrqrpiNKLUCO6NHp1ryjSRtPx1SHnllnpLggWunJoTcmZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M9TXrRK8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D9A606A321
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 19:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M9TXrRK8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BA81F000D0;
	Tue, 24 Nov 2026 19:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795547009;
	bh=hnJQ3SAGbAenoJqr6pKm7sS8tAraWbdlvOd3SGc6cO4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M9TXrRK8sSaaJJSRGTjav7iseBmQU4MZozmGIw0LL4v480hoMTotWzqyXsE/3YEd/
	 Ga1Uci7jsPln2avO64/LqaRCeryC9xsZRPM/9gN0t/AD42YIqE5UfwM8HY1UvPq3LK
	 vETvWiRPEU0Tun6BSR6D951piCRMhbCXciXVvW1SVSifLUR3eqtE/kAHGh8GMqVDhy
	 9bzwUojIRa05fBRLnPAtXJCXjiOMQSQN8PXF9Gji+eGujot4xGHUP/lHqmeXQ+CqKD
	 0fQRG3hzuoAamjGEWm/6/AaW8KEH8qyTS3y2XhMOoA5b1ZkE9nmppuMByonv3PZTIi
	 yUx28s4oaT71g==
Message-ID: <sashiko-outbox-231875@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 10/17] perf tests record: Exercise more record
 options
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261124184604.24983-11-acme@kernel.org>
References: <20261124184604.24983-1-acme@kernel.org>
 <20261124184604.24983-11-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 19:03:29 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [Medium] perf tests record: invalid --switch-output=3Dsize=3D64K in
  test_switch_output()
- [Medium] perf tests record: unguarded --aio options fail when
  HAVE_AIO_SUPPORT=3Dn
- [Medium] perf tests record: unguarded --threads=3Dnuma fails without
  NUMA or node CPUs
- [Medium] perf tests record: --threads tests do not raise soft
  RLIMIT_NOFILE ulimit
--

commit effd3981a11a3f57fa8f8fe4b22989f457d3f787
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tests record: Exercise more record options

This commit adds a new shell test script, record_options.sh, to exercise
various perf record command-line options.

> diff --git a/tools/perf/tests/shell/record_options.sh b/tools/perf/tests/=
shell/record_options.sh
> new file mode 100755
> index 0000000000000..b2bf51b5dc44c
> --- /dev/null
> +++ b/tools/perf/tests/shell/record_options.sh
> @@ -0,0 +1,173 @@

[ ... ]

> +test_switch_output() {
> +	echo "Record switch output"
> +	if ! perf record -q -e cpu-clock -c 1 --switch-output=3Dsize=3D64K \
> +			-o "${temp_dir}/sw" -- sleep 0.2
> +	then
> +		echo "Record switch output [Failed: perf record failed]"
> +		err=3D1
> +		return
> +	fi
> +	if ! ls "${temp_dir}/sw".* > /dev/null 2>&1
> +	then
> +		echo "Record switch output [Failed: no switched files]"
> +		err=3D1
> +		return
> +	fi
> +	echo "Record switch output [Success]"
> +}

[Severity: Medium]
Does --switch-output=3Dsize=3D64K actually enable size-based output switchi=
ng
in switch_output_setup()?

switch_output_setup() expects a bare size or time value such as
--switch-output=3D64K without a "size=3D" prefix.  With "size=3D64K",
parse_tag_value(s->str, tags_size) fails because strtoul() stops at the
leading 's', and parse_tag_value(s->str, tags_time) then matches the
leading 's' as a 0-second time tag, leaving both s->size and s->time as 0.
Because switch_output_setup() still sets rec->timestamp_filename =3D true,
perf record renames the single output file to sw.<timestamp> at exit and
the ls check passes without any output switch occurring.

[ ... ]

> +test_record "aio" "aio" --aio=3D2

[Severity: Medium]
Will this test and the "test_record_option aio-one --aio=3D1" test below
fail on builds without HAVE_AIO_SUPPORT?

In tools/perf/builtin-record.c, the --aio option is only compiled in when
HAVE_AIO_SUPPORT is defined, so passing --aio unconditionally fails with
an unknown option error when perf is built with NO_AIO=3D1 or against a
libc without POSIX AIO.  Guarding both subtests with
"perf check feature -q aio" would avoid this failure.

> +test_record "threads core" "threads-core" --threads=3Dcore
> +test_record "threads package" "threads-package" --threads=3Dpackage

[Severity: Medium]
Can the --threads subtests fail with EMFILE on high-core-count systems?

Each --threads run opens per-CPU event descriptors, per-CPU directory data
files, and control pipes per worker thread across all online CPUs, which
exceeds the default soft RLIMIT_NOFILE limit of 1024 on systems with 128
or more CPUs unless ulimit -Sn is raised (as record.sh does with
16 * nr_cpus).

> +test_record "threads numa" "threads-numa" --threads=3Dnuma

[Severity: Medium]
Can --threads=3Dnuma fail on kernels built without CONFIG_NUMA or on systems
with CPU-less NUMA nodes?

record__init_thread_numa_masks() calls numa_topology__new(), which fails
when /sys/devices/system/node/online is absent, and then passes each
online node's cpulist to record__init_thread_masks_spec(), which rejects
empty cpulists on memory-only NUMA nodes with -EINVAL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124184604.2498=
3-1-acme@kernel.org?part=3D10
