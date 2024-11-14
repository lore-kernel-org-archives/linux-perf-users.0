Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286C115CD78
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Nov 2024 15:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731599805; cv=none; b=Y+L/hjvSTzwhU5bgQt20299O1jSJSf4GlwgMINnDoOHjPWAy39goRGTWjYxemx8w2kwCCjooK2dcNmzYAKEGAYcAzPpe9S5L8T1dl8uIp/A3N9WpaGlXmjRnmavt8omIBOEtvWqFpN+rSeduUgqFkTlQ3YZqN66XfFTHDAE7uFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731599805; c=relaxed/simple;
	bh=l8y2CQFdyP+z6rFm3Bis63v74Yhiu4caCti+3hdBAEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=j5LYFVoyye7HAgjVSDqoXKNbivDMTviqAE8ZSoFhIYUlj6wCwFyeW9f87HWJDXFGX9lj0R9pwryRr0tXJReWj2HCFEkQietZTCWopq65J/+cG4kVlNZP1u8xqvrNW6/4rk/vd0bFcvRRuB48z4MclVV1rBj04Aw1Mv3owG+tW+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cN6uAeGP; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cN6uAeGP"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-46101120e70so5424431cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Nov 2024 07:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731599802; x=1732204602; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81AR0nqANMN6aMq5KrYugXy1j3gTSrVRBRaPA29VnBo=;
        b=cN6uAeGPx0qrxr8QjDF5hFKuzyAq1RRiE0PKwppoe3miyHUmwxEvTCs5xW96aydtZ2
         Byz6zAESubaVTbZIBFqwDA/uzYNnsw2PkDPMGm4K92grf42JibhFQK6etUOcO8iGESzF
         0ssJzmrWTVt5RTd0jjgrG+Sk4isjah56/qkhkYTL49loP2d9CNWjFbaEMJNEhtyHSPZ5
         k2YjvVtgZ6dprwG/aAqEyjzwuD6G57nMIt43dfEi2a1iz9rsQJ/g7LvcuXgCnyvnViGV
         F/uBOGwG5Wv3AWCJLbCPmyOf5NV6H8d56B6vb1pbMughgOLo4IYr9bHtW3niYkA/iE11
         TFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731599802; x=1732204602;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81AR0nqANMN6aMq5KrYugXy1j3gTSrVRBRaPA29VnBo=;
        b=kpb/Fp/gLRqBrYgtPxZN/67LBrOP1Ue+5r5V2hGcWXGtSOLAq8gWC7z2mS85u9VlBj
         0vUaqrp27ADngmtPaVCCFIFmkSGlHJWxGzxPLNwxB6M0fBOOq7/GEngNNIvxQpPIIXRH
         r8fogyArfxeRa047d8qwLWSeFPjig0bqht3I06h30TTVig+/jdZAaMf8pTv0pbtbPsyx
         tfWPLkiyhirtlnbweGgtVeQYI0vYJyKS8+LHD3GFsu0KgnH1zC1T06daTPtQzP6/Ydxo
         giKgfI+ga41fBEB3yVwQxjMSj3iqmE8w0EzB8oTYhp+2lN8xWbhNLXvblwm+OrAtSrzZ
         uBDw==
X-Gm-Message-State: AOJu0Yzlqxhn1kKBQN77Wnfcyr9TOoSUj2gvqcCe48c5pw+b1iVTvWth
	2QguWXqzlekol+z9FGNSEKQue5jMWnqQ61P8r+BEdq4dOWUvNSMsuDblE+cWJajSj/3zx2SXXVv
	KDppzHPyOLFhRARpx2L/RbH3bj3xWAw==
X-Google-Smtp-Source: AGHT+IH/gimkAIlOg4tC702ULlhnRCfmnW5+jhpBJ9UYlAde6bFL4Z8aUGixknokqS0seO/lsHDuHImCsiSWBadow0E=
X-Received: by 2002:a05:6214:3bc6:b0:6ce:d6c:499b with SMTP id
 6a1803df08f44-6d3d03a9575mr155014796d6.42.1731599802531; Thu, 14 Nov 2024
 07:56:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1731300662-5325-mlmmj-28e386a1@vger.kernel.org>
In-Reply-To: <1731300662-5325-mlmmj-28e386a1@vger.kernel.org>
From: Deva Narayana Babu <dnb.ranjikaa@gmail.com>
Date: Thu, 14 Nov 2024 21:26:05 +0530
Message-ID: <CACvH6ToqaADXOrJh8UpapnGtVkn3W+HYQ7kHK8ByQgin4jnFBg@mail.gmail.com>
Subject: Fwd: HTML message rejected: Building perf from source, with changes
 in source code
To: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Subject: Building perf from source, with changes in source code

I use kernel `6.6.55` so when I tried to build perf from source, I was
getting the following error, and when I changed some code(diff output
given below) the build happened. Is this a bug?
=E2=9E=9C  perf make
            [....]
  CC      util/synthetic-events.o
  CC      util/data.o
util/thread.c: In function =E2=80=98thread__free_stitch_list=E2=80=99:
util/thread.c:481:17: error: implicit declaration of function
=E2=80=98map_symbol__exit=E2=80=99; did you mean =E2=80=98symbol__exit=E2=
=80=99?
[-Werror=3Dimplicit-function-declaration]
  481 |                 map_symbol__exit(&pos->cursor.ms);
      |                 ^~~~~~~~~~~~~~~~
      |                 symbol__exit
util/machine.c: In function =E2=80=98save_lbr_cursor_node=E2=80=99:
util/machine.c:2540:9: error: implicit declaration of function
=E2=80=98map_symbol__exit=E2=80=99; did you mean =E2=80=98symbol__exit=E2=
=80=99?
[-Werror=3Dimplicit-function-declaration]
 2540 |         map_symbol__exit(&lbr_stitch->prev_lbr_cursor[idx].ms);
      |         ^~~~~~~~~~~~~~~~
      |         symbol__exit
  CC      util/tsc.o
  CC      util/cloexec.o
  CC      util/call-path.o
  CC      util/rwsem.o
  CC      util/thread-stack.o
  CC      util/spark.o
cc1: all warnings being treated as errors
  CC      util/topdown.o
make[4]: *** [/home/dmacs/Downloads/linux-6.6.55/tools/build/Makefile.build=
:98:
util/thread.o] Error 1
make[4]: *** Waiting for unfinished jobs....
cc1: all warnings being treated as errors
make[4]: *** [/home/dmacs/Downloads/linux-6.6.55/tools/build/Makefile.build=
:97:
util/machine.o] Error 1
make[3]: *** [/home/dmacs/Downloads/linux-6.6.55/tools/build/Makefile.build=
:150:
util] Error 2
make[2]: *** [Makefile.perf:666: perf-in.o] Error 2
make[1]: *** [Makefile.perf:242: sub-make] Error 2
make: *** [Makefile:70: all] Error 2


 On inspection I found that the function/macro has been used but has
not been defined anywhere so I followed the compiler's directive and I
changed the function name to what was mentioned and `perf` got built.
The diff is given below:

=E2=9E=9C  tools diff -r /home/dmacs/src/linux-6.6.55/tools/perf/ ./perf
Binary files /home/dmacs/src/linux-6.6.55/tools/perf/pmu-events/__pycache__=
/metric.cpython-310.pyc
and ./perf/pmu-events/__pycache__/metric.cpython-310.pyc differ
diff --color -r /home/dmacs/src/linux-6.6.55/tools/perf/util/machine.c
./perf/util/machine.c
2540c2540
< symbol__exit();
---
> map_symbol__exit(&lbr_stitch->prev_lbr_cursor[idx].ms);
2841c2841
< symbol__exit();
---
> map_symbol__exit(&stitch_node->cursor.ms);
diff --color -r /home/dmacs/src/linux-6.6.55/tools/perf/util/thread.c
./perf/util/thread.c
481c481
< symbol__exit();
---
> map_symbol__exit(&pos->cursor.ms);
492c492
< symbol__exit();
---
> map_symbol__exit(&lbr_stitch->prev_lbr_cursor[i].ms);
