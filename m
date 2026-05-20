Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB0E332608
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 15:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779291997; cv=pass; b=dXubW2gJZOD/KXfCgGK3Y3bzS9YMasRO2crcsPYj2p3c5XJbI1w/UtCtRk8lysYBWfMtFeDBdIsMnzkeJqmGM9apkxUpV1aArK3a8Tad4sQt3tUB/yIxr15sC1Ekwnf+NKtrGfDsnQIt7QLJWY2EOIBLEMrgySOmy8sYriAOr6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779291997; c=relaxed/simple;
	bh=8kYfk49oUNp6a5XXry77NJu1BuF15NQRgg3luJyEZnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ewyZFAwFLjqRaBqFadMBZe9EtH9Y3Z5H9PcM46YpD54yEroCNVgLSdvyx13ZT9JUiLCv0hI+qtnt0qoSRMwbw75QFuHIx22C9ZtTMxiKTW4F/MVNyQA0MdT4VJuH+be33GJx9kzA6D2Fk2DTO25kllTVbl82WiVjsHmBqy1vH5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DXr4FtRM; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DXr4FtRM"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso2055ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 08:46:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779291995; cv=none;
        d=google.com; s=arc-20240605;
        b=fsQPy1Khrxl9YdODZ/r8idrFLEhzR5jCMbUHCEf0LbhASMskW3c8KDavh6lTHyD9mR
         x2s3/PkPgp72midS5UVn7h3m6YelNX22iHwi9TodmVxldBjwjOuKLGix0ps7BCVb9i9T
         833qbNg2NGurVwCKapUdbhuRZJtrUAUKpjmD4DeMFpNi/4bOZsQozs9uiJdnyn4VhdBm
         0WihY4I6GQ66Ez736pcbY9y/DsqrlEFfziljb5lCYxTWpx0QZGtXdBEDnEEW+P38D8G9
         OqD6rdQfs0iezRYpUKG6XmHooQdGWfdmspY9Jjyd4fJzOYTGkVgpD+M2lxtA2moS3oBT
         g30A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9MK+trDsear33NMZ8MwY4Sme2+qGejgeJc5ExRFH3sM=;
        fh=XhaAOgVeG97L/DwDHoEwV0NWeDfQSwhjdfNdW3jZ1AA=;
        b=X05zBCHuJ7hmlbeplvDWWB4MquKKl+RgHsCyfF3Zb9Dbgv3sR8U+uqRAeJg/pUh9HJ
         oUNCIFdboTE6PzYLRWr4raxHp0wLBhKeMXIQgxBBtVOmuo2pIUej8M+GYSqeBE/lxjr0
         Ys2ZrMpEMAZIDuz0tiVem3ee2R6ZWf9A0vnqo8q/DxoUGbBz6PKAj5ojoEMSNW9EEa8D
         TmKAgoTBXBPDEsgWKOoFJIVqob1YXMMn3X1FrkvZDsNHtrGt0SdWOAA0Vcx+GpF12UI1
         Ja97ai/g4I6ozug0cJNjri15US+8l/qHVangRdYZLNMfJNGuvu3DgNKQFzpRJxvKiTaw
         qM3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779291995; x=1779896795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9MK+trDsear33NMZ8MwY4Sme2+qGejgeJc5ExRFH3sM=;
        b=DXr4FtRMMcmFQ1LPmiplLoKpvBxuv6EbGcmFGILv/g0IC+C9Fk+tK+xcA77qjQsXkO
         yBU/iJ3UtWLlYdvQZE80XWgmydJnBctL4gaiIVnS2HWzOOgEaVThT37H1uVnuXpxbCkl
         0jFWEZkzzgLS0ZG51M81aZeWeoAfkhpk0oSAumoYD/XTUYxuLiQwnGNzUIynI0rXAAr6
         +508L62aS0jbQlj/jyusF5RLrzr15IWsBmCGvuByaDzPcI8CMtmg8mB6GZ+BrRu7eYuy
         SZNaye7lKF7ycp7aHoyZoVkQ5TZtnGOV3g6ft+lOwyyP8IxLPFcRbfLkr36erRPs0mhY
         LgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779291995; x=1779896795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9MK+trDsear33NMZ8MwY4Sme2+qGejgeJc5ExRFH3sM=;
        b=HvqVnmxqACK4y17R+uBA5NVyb0s2IzEWReekbiTkbKwlXkYhnDVaIxpSDKTmOh1FLV
         e/n6cRyQBwDQ7hn5lKa08WKhBLusUj3rS4U4ZpDKaI4HJ5g5ba/XEhSFn5cCeEqbxkj9
         2u9DQMFMFpeAHAAlhXomNeZGzO+hCJhzOkEYqAIWg0btWW/FVgATwNXgJFH8nNzM6OvF
         E7Q/7D0ZOtCUtOiC8tR4zHuDtIAZpRwa0jBBau8grjpFhGTaBDeX3xtu4HP9cnB+cs5J
         LtOYTKxfxaHE/cD9PVRBm0NT7Wkv65gIvJC2GrK1ALFyglVA9Tzz3bk5tsqCxjBZprI5
         7+rw==
X-Gm-Message-State: AOJu0Yy8xcvaOVd0lMfzHIlh9odoG8EOAPGKp9WeylN023McVDtJwKpo
	zu9902Mm+RR2FYL26jZiH6tTaaWvYSwdr7Ok13bImCbqZ4+sdDD6ctuCRGPJfRhIG24iBRylnL0
	lS3gLenqr1L77aP1rwq+yzmFvSEjNp7bWk4Lsgh1w
X-Gm-Gg: Acq92OElIUkI1F/9jtk+YGkQA2ArLOMZK6l3RMOYOArcUz0NQBuYmHaxPm3i3uZmiDe
	8LT819YpVpJrqSpQYO9WMrclEl/1KJVwcN6IphuYeO8k68XuC/uONY/oc97nRoALaFX3qpRG3+X
	xaiZ2NhFbEZIMxFASQggF118y3mqayb7ant9444Uc6CDc9IOMF7dci699NbuWbipEJPgZQ5euKE
	VcwaAu+O1JvCAcPDGaoLpgf/Exug7nTmq3DhZpiZJUb/wWBPTptJUWDxPZ0eYKreFo5p1bnRhrj
	XKql8wYWOUSRMMoLT1eIRaVnjYB+NZweQDbZzqWWED7X/VVa
X-Received: by 2002:a17:903:46ce:b0:2bd:9e75:9e98 with SMTP id
 d9443c01a7336-2bdb329b484mr10140265ad.9.1779291994933; Wed, 20 May 2026
 08:46:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <314df838-4c38-4f03-9515-ae1dabd09a54@linux.ibm.com>
In-Reply-To: <314df838-4c38-4f03-9515-ae1dabd09a54@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 20 May 2026 08:46:23 -0700
X-Gm-Features: AVHnY4Jam-xOebnFa2eKgXOBynPpveNJLerM5lyI7bkcsHXN_2PUoqPzdZPKXoo
Message-ID: <CAP-5=fUDqHGeM36TrfLxOgC8_ohp8fshtpRJMf7-utkSn3drmQ@mail.gmail.com>
Subject: Re: perf test case 'perf kwork record' fails due to abortion
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 5:53=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> The test case
> # perf kwork record -- sleep 1
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.280 MB perf.data (568 samples) ]
> double free or corruption (!prev)
> Aborted                    perf kwork record -- sleep 1
> # echo $?
> 134
> #
>
> The perf kwork record is kill with signal 6 (SIGABRT) and the test fails
> on x86_64 and s390, probably on other platforms as well.
>
> Is this a known issue?

I can reproduce this with an asan run:
```
--- start ---
test child forked, pid 4058074
Kwork record
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 4.949 MB
/tmp/__perf_test_kwork.perf.data.fyllr (17753 samples) ]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D4058078=3D=3DERROR: AddressSanitizer: attempting double-free on
0x7b2caa3e6a10 in thread T0:
   #0 0x7f0cb8318d6b in free
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:51
   #1 0x563b32733077 in perf_kwork__record
/usr/local/google/home/irogers/repos/linux4/tools/perf/builtin-kwo
rk.c:2335
   #2 0x563b327363ad in cmd_kwork
/usr/local/google/home/irogers/repos/linux4/tools/perf/builtin-kwork.c:2494
   #3 0x563b327dfffa in run_builtin
/usr/local/google/home/irogers/repos/linux4/tools/perf/perf.c:348
   #4 0x563b327e0498 in handle_internal_command
/usr/local/google/home/irogers/repos/linux4/tools/perf/perf.c
:398
   #5 0x563b327e0866 in run_argv
/usr/local/google/home/irogers/repos/linux4/tools/perf/perf.c:442
   #6 0x563b327e0dbd in main
/usr/local/google/home/irogers/repos/linux4/tools/perf/perf.c:549
   #7 0x7f0cae029f76 in __libc_start_call_main
../sysdeps/nptl/libc_start_call_main.h:58
   #8 0x7f0cae02a026 in __libc_start_main_impl ../csu/libc-start.c:360
   #9 0x563b3261a3b0 in _start (/tmp/perf4/perf+0x2243b0) (BuildId:
c542d90b5244b118cf9b3a20501260c659421a94)

0x7b2caa3e6a10 is located 0 bytes inside of 6-byte region
[0x7b2caa3e6a10,0x7b2caa3e6a16)
freed by thread T0 here:
   #0 0x7f0cb8318d6b in free
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:51
   #1 0x563b32733077 in perf_kwork__record
/usr/local/google/home/irogers/repos/linux4/tools/perf/builtin-kwo
rk.c:2335
   #2 0x563b327363ad in cmd_kwork
/usr/local/google/home/irogers/repos/linux4/tools/perf/builtin-kwork.c:2494
   #3 0x563b327dfffa in run_builtin
/usr/local/google/home/irogers/repos/linux4/tools/perf/perf.c:348
   #4 0x563b327e0498 in handle_internal_command
/usr/local/google/home/irogers/repos/linux4/tools/perf/perf.c
:398
   #5 0x563b327e0866 in run_argv
/usr/local/google/home/irogers/repos/linux4/tools/perf/perf.c:442
   #6 0x563b327e0dbd in main
/usr/local/google/home/irogers/repos/linux4/tools/perf/perf.c:549
   #7 0x7f0cae029f76 in __libc_start_call_main
../sysdeps/nptl/libc_start_call_main.h:58
   #8 0x7ffda79dc4ee  ([stack]+0x204ee)

previously allocated by thread T0 here:
   #0 0x7f0cb8313e20 in strdup
../../../../src/libsanitizer/asan/asan_interceptors.cpp:593
   #1 0x563b32732ddb in perf_kwork__record
/usr/local/google/home/irogers/repos/linux4/tools/perf/builtin-kwo
rk.c:2322
   #2 0x563b327363ad in cmd_kwork
/usr/local/google/home/irogers/repos/linux4/tools/perf/builtin-kwork.c:2494
   #3 0x563b327dfffa in run_builtin
/usr/local/google/home/irogers/repos/linux4/tools/perf/perf.c:348
   #4 0x563b327e0498 in handle_internal_command
/usr/local/google/home/irogers/repos/linux4/tools/perf/perf.c
:398
   #5 0x563b327e0866 in run_argv
/usr/local/google/home/irogers/repos/linux4/tools/perf/perf.c:442
   #6 0x563b327e0dbd in main
/usr/local/google/home/irogers/repos/linux4/tools/perf/perf.c:549
   #7 0x7f0cae029f76 in __libc_start_call_main
../sysdeps/nptl/libc_start_call_main.h:58
   #8 0x7ffda79dc4ee  ([stack]+0x204ee)

SUMMARY: AddressSanitizer: double-free
/usr/local/google/home/irogers/repos/linux4/tools/perf/builtin-kwork.c:
2335 in perf_kwork__record
=3D=3D4058078=3D=3DABORTING
Unexpected signal in test_kwork_record
---- end(-1) ----
93: perf kwork tests                                                : FAILE=
D!
```
And it looks like I sent the fix a while ago:
https://lore.kernel.org/linux-perf-users/20260512223001.2952848-32-irogers@=
google.com/
I plan to rebase and resend that series today.

Thanks,
Ian


> Thanks
> --
> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, German=
y
> --
> IBM Deutschland Research & Development GmbH
>
> Vorsitzender des Aufsichtsrats: Wolfgang Wendt
>
> Gesch=C3=A4ftsf=C3=BChrung: David Faller
>
> Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stut=
tgart, HRB 243294
>
>
