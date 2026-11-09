Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794248422;
	b=JZsLJZApVaj59OyepYazBo+rUdGtuS6yjVYbYkQvP+IQ5O0I7MEx/NEp85f8Nk8HHCaz
	 Gt3ZpJ2mvT7eTlVWYcvsXBX98JswSuYlSQ07N74Bfps0KTTIMorsCJ50rA3s1pIHPMDe0
	 VX7ezJq5QlQyMpJJ4D558RKrBvVFmR+wBeXvAUCSYkdVDvvjhwP4sT2lMD28POSgaccuY
	 Zlem4ftuNDJBjl7xDAitN4K/pR4qn8hBKeu5eH1Jw0zmx+GxKJF2MFWMFlc1Ykvx0xlcN
	 MkTdybcv7iEzz9/5pVMdsDZaHRxj+a5HwfD4lxQceU4lOcIFQgcuNyfpr5cUO5sfXow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248422;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ec3rSrMbZ8GmXw0Jux1jLXyWIwWhDxqyeBtx6xUwW1Q=;
	b=07ZpjAAwHMWvskPiSBU/U8eNcp4T7r+zTaTXarY6w35n2UmJHjMOHahcvNjl6eyLlcxb
	 NiIHQ+I2QknkLKFWKQtW4Lsl28Cbcmutb7HAVkGkB64FuIxQRbBoyo0lzW1FvHfjCTD2s
	 CffQIQcf77TOktIQgRB1WBnotcnLwdReS9Dcd9SwMUTYCim9DyfBMI+qEbnl0WRrWfGG0
	 WcyNara25gqhqol2wN2oOMDTHTCAJvB4b3RQhSky0dpRoWvasfbf9r/H4yVlqM+QiZ3AH
	 87EP3hRcvFiwgQkBi4krs0KvcjaNACaOULIVPxlPYv2OuEK44JHjqqO+AI+3DUGv/xg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AH0gZGsz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CB3606A326
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 18:20:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59CB3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AH0gZGsz
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-150ef97e790so534c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Nov 2026 10:20:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794248421; cv=none;
        d=google.com; s=arc-20260327;
        b=UGaijFsr5dvJODICLThhNNBNyB3IpWik6a//lpgiAVukyuTY8KtS3k+ha/OzLJ7D23
         MPkskgb0259JR8bP4hQb8vg8jVaXhlTdTMHcBiD2Tq0UeRJVPfV2SazLX2/+lzB5Rd7u
         B3WSYi+voa0mdjzI8uvVwW+tiFiIIg0P1UsTLtAylPytoVFBZSdXbgaO/dWUnaVQNa4+
         bztw5GjVZbWpK1tJ2jIoUajh5bE0JdI3OifwwLcRn4lw4+0dqo2imzS3U1T2q9mIhsZy
         RUgmCCzFnjwBlRWYoV3pV5H2ICDDCxLZA9bqtD8bAwnCZBK5O8+0pkPNSH/2XyoGI/Wc
         Ih4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ec3rSrMbZ8GmXw0Jux1jLXyWIwWhDxqyeBtx6xUwW1Q=;
        fh=MjuHx+qvhJmyhnMnwsJEaFQjwGrwbxUtmRMHjqlrIC0=;
        b=AqAl9ZlGgWFMj+iSM33XmyWtj8k9ZiCECtFx38sZRuSlFHvOB3y0crdWNRc9bC4v3k
         uYYJ8em/C0MkX44xw9KbD3DWaheEWvjO1ayNrHVMGR2G/NfC7aYH1R8qIuES+vO/zN6Z
         G7hT8kwvM5NO26VttJU+NRTSRF7Yr52tNkqLkL0R6Fob7Vug+gYqpaip7f4lWcAspJ6t
         ITv4eDrPspDCiPn/P4+e8JrSwZLuKt50vviPpkTS0AJsl5h1PuhudY46F82WkylHyRK4
         oO1fdC38HNSFjz78OxvAiU2HK49LXPVOuG+As+MBwogXrFypXXDakFlT3Mvful4hKe0j
         EJhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794248421; x=1794853221; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ec3rSrMbZ8GmXw0Jux1jLXyWIwWhDxqyeBtx6xUwW1Q=;
        b=AH0gZGszlxMedBOIhGpjVJylI93uLea+9zIreqRbqB/UJFem+6skMZWtk4cM34qZe0
         XH2KMuaCR8u9aFHRXQqjxrrr2x/GTKkL/KiFC+uF8Tqx2uwu0Mrv7U4ihVRFDyDX66Dx
         jCOxTD7M+spO5/rITC2+EFw+02R8Zrr0TQVkQi1l2pXj4A3R7JwGLJnVaOznTDaAJc8W
         h3Nf6R7y7QPw/y7cn97eM4VwCUPxb1TJmHQatU1S1ti10oIqsBpsqx2qQjNmkygDuSGY
         tF4R2Eqs8HVJCdVJTT/zy2n7XOSdBzY1O1kUeRn+gA5kz78+yCJKlO8NJqCtDNVaLyZF
         oXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248421; x=1794853221;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ec3rSrMbZ8GmXw0Jux1jLXyWIwWhDxqyeBtx6xUwW1Q=;
        b=NqRe3qJ8NHYxmeh23zuVqkWsZuJpQOMBTZ3R49B16v1bsCSK7nH13XnYZHtUlfzZum
         rfzcXhl5BG2XXbR9AzWW86mvGT5fBXjpOKIniuszGN9G91RF06DR0DNCv197kRpe4/FG
         PpdftCKdeVH7Ele41GR7YpK2hArgD70bZMTZdmqnS7R8TsauICEp3InIGPwYIIQpQcaj
         hTCNgrKnHa/hhjdrMdN8CXFEUOI6fmVOLx/tGGv8W71LLD4VcvqK7L51ku3HBnFcvTDj
         HvplcqiC+VSW9dPB4hXA0doxD352DeHlwv3LLy75JBqo1Yhy0tC0vwHDPldd+zYu4L5s
         jDFQ==
X-Forwarded-Encrypted: i=1; AL+hErEc5Nxdxtb2cLqInpA0ZeuzZWKCztiRET0+LDt3obMfHfHdjBIVhjhLCVWoKSl+4uu5C48L9vZIzV7djyyZe1Bl@vger.kernel.org
X-Gm-Message-State: APuU4Z8kWH7Zvb4o5i113StSmHjre2xBiwBPFM8ClxcnzyMIrra3W16m
	d1Qgbo39hTFpFhyB51zoANDhJG0TLHGcX8cc3LGeEqoPMpuZXNiWkci/gcmJJgYKdgRN0WFn3QR
	/MEs3c8OvtCr8oYtNlUvNxuU65B+ohKEfusw9XMc3
X-Gm-Gg: AYBFou1fPWFf/YO16WwETCYANsYqgtPCIWWsChu3d663OMI/SAha4nuoUr2VONimu4K
	eFWOFtqACZuXkWrk4kr68PSmdL9Ynd9BrBD21gN8dOBZS83PUGzTkbnQrCnu/L3VLD1EtH7mO7I
	bu5BD8z1/wAS7+6TTrUKGAhb9Bt0xi8nc/zj2uCz9bFnf/J3h4pZhgqknTuFLbRxeuBmf4hXDo6
	nDEf4vxBtQhrd2HjVVpMUCq/VfzmP+z2WbqnkY1FkixH0oI2kH+cNujhiDRjdpoiT4DjyqsNxpy
	yMxQi5VxkurewG/sRMAt6Wy5myk7mo3HT3qgdhEfGu++2U3oOWpDw7Fmmm/y71xEEp2af5b3tgI
	yvQslHpT+KjlWwPn6AGsQJS/I6O9hDL3I1v5gapf7VuAHeh81zuXHmYET11Wy+zN8YiY=
X-Received: by 2002:a05:7022:ea8b:b0:14e:e4bf:7974 with SMTP id
 a92af1059eb24-1b3b66842a4mr9502c88.4.1794248420013; Mon, 09 Nov 2026 10:20:20
 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109-james-perf-test-fixes-v4-0-355ee6b81917@linaro.org>
In-Reply-To: <20261109-james-perf-test-fixes-v4-0-355ee6b81917@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Nov 2026 10:20:06 -0800
X-Gm-Features: AclHuK9DNekpxwBEfz2zjyCpyugGoj1l-_2rYK3b_X2Xz0sEkpkfXtYjLA4ppIM
Message-ID: <CAP-5=fWpnzp4O-kKqToP0Q7WVp1dcPaUH1MgPNiL__MNJKZ7hQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] perf tools: LLVM dwarf and flaky test fixes
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Jakub Brnak <jbrnak@redhat.com>, Leo Yan <leo.yan@arm.com>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 5:48=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
> Running the tests on an LLVM build results in some dwarf issues that
> need fixing. And there is an easy fix for some flakiness caused when
> tests are run in parallel.
>
> Assisted by Claude Opus 5.5
>
> Signed-off-by: James Clark <james.clark@linaro.org>

For the series:
Tested-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> Changes in v4:
> - Remove unused add_probe_vfs_getname() argument to fix shellcheck.
> - Link to v3: https://patch.msgid.link/20261109-james-perf-test-fixes-v3-=
0-e8d0a65e618a@linaro.org
>
> Changes in v3:
> - Rebase to resolve new conflicts
> - Link to v2: https://patch.msgid.link/20261106-james-perf-test-fixes-v2-=
0-9a912662f822@linaro.org
>
> Changes in v2:
> - Break perf probe line (Namhyung)
> - Use a software event instead of cycles for VM compatibility (Namhyung)
> - Link to v1: https://patch.msgid.link/20261105-james-perf-test-fixes-v1-=
0-0b279bee5830@linaro.org
>
> ---
> James Clark (4):
>       perf libdw: Find the CU by iterating all CUs when aranges are missi=
ng
>       perf dwarf-aux: Support DW_OP_addrx locations for global variables
>       perf test probe_vfs_getname: Fix missing debuginfo detection
>       perf test: Don't starve per-process tests with system-wide events
>
>  tools/perf/tests/shell/lib/probe_vfs_getname.sh |  9 ++--
>  tools/perf/tests/shell/record.sh                |  6 +--
>  tools/perf/tests/shell/record_lbr.sh            |  2 +-
>  tools/perf/tests/shell/record_sideband.sh       |  4 +-
>  tools/perf/util/annotate-data.c                 | 27 +---------
>  tools/perf/util/dwarf-aux.c                     | 70 +++++++++++++++++++=
+++---
>  tools/perf/util/dwarf-aux.h                     |  3 ++
>  tools/perf/util/libdw.c                         | 19 +++----
>  8 files changed, 90 insertions(+), 50 deletions(-)
> ---
> base-commit: 13a8d580433a3b72b10be34f0e26787fe5659d3c
> change-id: 20261104-james-perf-test-fixes-f72265531d1a
>
> Best regards,
> --
> James Clark <james.clark@linaro.org>
>
