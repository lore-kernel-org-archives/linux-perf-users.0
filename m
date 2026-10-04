Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCB04503F3
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Oct 2026 17:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791135830; cv=none; b=s15kJgSG7+3MeYcxof0gkt0TFAYGMoM7RBjx5gR6XGfPAgA+ONRRdvgTwv9dpILS/zq17EoF9bxFS4QfIG7Uxo9Vgmb5XZnJ2hXsSM76TLOGkMcJM8XNBtrrLHWPtmFPYhpdQl8UNzZqtX1D3QuXKFj2OIvoCb7gG1ISsEuzYRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791135830; c=relaxed/simple;
	bh=FUitoVcD+4IbzgMKoUxNyvV/pI21kq5QUSs3LET9lFQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CtZlqjXJkJ4YoBpgiocNiCi0YHmQgl761qjzbusoccxkzdr1opD6WuU3IkiLzJbOfRfeA9JrBRpaOPsNLjJLe30blBqHYNRcSru9zccsHBXcmm6/CC3CrxRuj7/MEP/yp/nn+8XkETxIVGu4sNJgUJlDICuVHKcnUA6KtyLoVX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzH5dhKe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzH5dhKe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285441F000FF;
	Sun,  4 Oct 2026 17:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791135829;
	bh=NB/8Xlt5Wu4tDvvfZ5gqY+iypc30LFwpUhtwbAivKIU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kzH5dhKeP8+id0+VTuUZOniJHjwtQArqJbq8TV4YyAAZ+XbuFY7QHGL++pL84zDlX
	 q6Fb87U1nyxLcm/ZDokPGgFfD4CIBdLuRTRAjCRVZfQYiQVm7afyxr+ocAlX60DUUO
	 6W39+SfmXroHhmBBXzJfAZ5uYdTGaTO5qNFpqkAuN3JqohXwaJ4D23mrKNcRkjI2Fl
	 Hf+oNFVyl1JVa8FpR8lmPMPg+QUGawl88Cu088qKGFSql0IRNRXxzYtTPll9jotZfj
	 zDMa/O+nZIMrT+6klLA6tx7w3WyS7NS2j3C59Nx9VSNOz6lpOwzZPTOOCNNHxzvdWP
	 c70kyNe18DnTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] selftests/perf_events: add userspace AUX regression
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kunwu Chan" <kunwu.chan@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261004173458.837842-5-kunwu.chan@gmail.com>
References: <20261004173458.837842-1-kunwu.chan@gmail.com>
 <20261004173458.837842-5-kunwu.chan@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 17:43:48 +0000
Message-Id: <20261004174349.285441F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] selftests/perf_events: spurious failure on strict perf_event_par=
anoid
- [Medium] selftests/perf_events: reading aux_head before disable causes sp=
urious SKIP
- [Medium] selftests/perf_events: inconsistent PMU config rejection handling
- [Low] selftests/perf_events: missing -latomic causes 32-bit build failure
--

commit d2d3116ff9e5d31817ce92f2b014df0cd0508f17
Author: Lian Wang <lianux.mm@gmail.com>

selftests/perf_events: add userspace AUX regression test

This commit adds a C program to test the userspace AUX mmap protocol.
It verifies that the perf event AUX setup handles configuration, memory map=
ping,
and independent event buffers correctly without breaking user space.

> diff --git a/tools/testing/selftests/perf_events/Makefile b/tools/testing=
/selftests/perf_events/Makefile
> index 2e5d85770dfea..fbafbd43f097e 100644
> --- a/tools/testing/selftests/perf_events/Makefile
> +++ b/tools/testing/selftests/perf_events/Makefile
> @@ -3,4 +3,5 @@ CFLAGS +=3D -Wl,-no-as-needed -Wall $(KHDR_INCLUDES)
>  LDFLAGS +=3D -lpthread

[Severity: Low]
Since the tests in aux_kernel_usermode.c use 64-bit atomic operations on
__u64 types, does the Makefile need the -latomic flag? Building on 32-bit
architectures usually requires linking libatomic to avoid build failures
on 64-bit atomic loads.

> =20
>  TEST_GEN_PROGS :=3D sigtrap_threads remove_on_exec watermark_signal mmap
> +TEST_GEN_PROGS +=3D aux_kernel_usermode
>  include ../lib.mk

[ ... ]

> diff --git a/tools/testing/selftests/perf_events/aux_kernel_usermode.c b/=
tools/testing/selftests/perf_events/aux_kernel_usermode.c
> new file mode 100644
> index 0000000000000..5c2da4bac0740
> --- /dev/null
> +++ b/tools/testing/selftests/perf_events/aux_kernel_usermode.c
> @@ -0,0 +1,627 @@
[ ... ]
> +static int test_aux_mmap(int pmu_type)
> +{
> +	struct perf_event_attr attr =3D {};
> +	struct perf_event_mmap_page *mp;
> +	void *aux_base;
> +	unsigned long aux_size, aux_offset, mmap_size;
> +	int fd, ret;
> +
> +	attr.type =3D pmu_type;
> +	attr.size =3D sizeof(attr);
> +	attr.disabled =3D 1;
> +	attr.sample_period =3D 256;
> +
> +	/* ARM SPE requires period mode (freq=3D0) */
> +	attr.freq =3D 0;
> +
> +	fd =3D perf_event_open(&attr, 0, -1, -1, 0);
> +	if (fd < 0) {
> +		FAIL("AUX mmap: perf_event_open failed (%s)", strerror(errno));
> +		return 1;
> +	}

[Severity: Medium]
Could this cause a false positive failure if the PMU legitimately rejects
the zeroed configuration? Later in test_aux_head_monotonic, the same fd < 0
condition correctly uses SKIP to handle PMU rejection. Should this also skip
rather than failing entirely on systems with strict AUX PMUs?

[ ... ]

> +static int test_aux_head_monotonic(int pmu_type)
> +{
[ ... ]
> +	/* Read initial head */
> +	head_before =3D __atomic_load_n(&mp->aux_head, __ATOMIC_RELAXED);
> +
> +	usleep(100000); /* 100ms */
> +
> +	head_after =3D __atomic_load_n(&mp->aux_head, __ATOMIC_RELAXED);
> +
> +	ioctl(fd, PERF_EVENT_IOC_DISABLE, 0);

[Severity: Medium]
Since head_after is read before the event is disabled, is there a chance
the hardware trace data hasn't been flushed to the ring buffer yet?
Hardware tracing PMUs typically only update the control page when explicitly
disabled or during an interrupt, which could cause a spurious SKIP here.
Would it be safer to disable the event before reading head_after?

[ ... ]

> +int main(void)
> +{
[ ... ]
> +	/* Test 6: Verify /proc/sys/kernel/perf_event_paranoid */
> +	printf("\n--- 6. Perf Event Paranoid ---\n");
> +	{
> +		FILE *f =3D fopen("/proc/sys/kernel/perf_event_paranoid", "r");
> +		int paranoid;
> +
> +		if (f) {
> +			if (fscanf(f, "%d", &paranoid) =3D=3D 1) {
> +				printf("  perf_event_paranoid=3D%d\n", paranoid);
> +				if (paranoid > 2)
> +					FAIL("perf_event_paranoid=3D%d may block AUX",
> +					     paranoid);

[Severity: Medium]
Since the selftest enforces root execution at the beginning of main,
does this sysctl value actually restrict the test? A strict perf_event_para=
noid
value greater than 2 typically doesn't block root users. Could this logic
incorrectly report a failure on systems with strict defaults?

> +				else
> +					PASS("perf_event_paranoid=3D%d (OK)", paranoid);
> +			}
> +			fclose(f);
> +		} else {
> +			printf("  [SKIP] Cannot read perf_event_paranoid\n");
> +		}
> +	}
> +
> +	printf("\n=3D=3D=3D Result: %s =3D=3D=3D\n", failed ? "FAIL" : "PASS");
> +	if (skipped)
> +		printf("=3D=3D=3D Note: some tests were SKIPped (environment)\n");
> +	return failed ? 1 : 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004173458.8378=
42-1-kunwu.chan@gmail.com?part=3D4
