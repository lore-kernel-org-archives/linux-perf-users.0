Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0A9224B14
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Oct 2025 15:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761147992; cv=none; b=mUtf63DYmltS1W4fLrD91/+ofs6lNsyddeZK/VWT8whGJ3xYR1VsWo3DUWqVq4hs4OYjHWT8SQrqBTzD4PP/BnBmUYa/d/vAKxJvnDmnCXRg5Q24hhb4LKg9fZKWKQvwyqk7/9PZ0A5a5qWxBY0O1lguAWRKIzuV51Im9I7wKhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761147992; c=relaxed/simple;
	bh=ekujxy+UFb0YpAeRLAHs88V3FcRJwlm0QE0mKkW+7CE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GHWF8dgoo/xgb9L8mgN5ySpxhWamllTTzWN3K6ViFY8H7vl89OCXXrqRTnt/F7SokN6vR5qkvY9RjGzXsTvvRwBQygRg2Rh62XexVlL6SRj2tt6Rp8Fu2sG0YJIYcMRGOf6bJjMETAa1lSJqhA4zFyyrJ6nalauXnZPo2vO1JK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yeOQCUkX; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yeOQCUkX"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3f2cf786abeso5408690f8f.3
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Oct 2025 08:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761147989; x=1761752789; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4S8eWzeWjY0y1rCtzP037XhZn6Fr5haqVonw4C5SH4M=;
        b=yeOQCUkXFEeJQpIPx6AmlinnYjGfqErWsDTRQX81k2+Nz3KVi66q1kwlYxWi5YNpo8
         0qXCaLh57wnu5/T6B851vchXyA5QU8Thq3cxArkeoGAXqHWTbThfgCKrKAaF4WWULkZ5
         C4jjWG4nz3dJYWJTcidwHF8hUNCvaz5WpTOLextStnze/dhUZutpl+OACPhfkmAdsIbh
         GtGCDQYpDln1lKNrorwN5ZNshpNtjHK4o+SLcqAXtkpnvdgsPrplKu6KuGc67RWb8PUy
         orSslmCuZf2oxc54fcUMDJk2yP5JneTueuqHV4gnRknhRlnXUIvysqYBMzjrX67pwIi0
         5hoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761147989; x=1761752789;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4S8eWzeWjY0y1rCtzP037XhZn6Fr5haqVonw4C5SH4M=;
        b=ppzdnXIMDwxblVTuBUxRsPmErZlHugj2CsA6esBszHp7kRrCDESB5Gi5FfJ89xiRgw
         LfPmCTrGTBbjtybMrPm35unnqfRSvI0MXrH02i0AliQQafMyBYdSpgEcFtk332TSm6h0
         Ckjj1HGgBsO3z9YN5jVax9eQSbIaeXKO37K62tzRfCZjCh826iwmV9NgsBToEyYSuQmx
         g30ftnthSo27Y7M5IMON/A4rpVfXS9FBZnC4mgN6aiLPpvHqLGEw/j0ucB9xF2V0EMC2
         r5Wynrr3zEXzarELGjn9/bCq4eh8+jpUYm+hvUF6OObnr/QokGNgV+Suum/xUY6M6QP6
         X1ag==
X-Gm-Message-State: AOJu0YziTJiOn2QYtFWB+R9UwSMEu4AsizopACdFv1fpzcoNmZbjagHF
	TqoIg/jJwFBw4R8rZEme+HRfTEo1v3R4HPkfHWWRpwyq/n9TeqcfbtoiqHxaYlgAH+l70c/kGKd
	FTj6SWis=
X-Gm-Gg: ASbGncuslsHj24x7Ff13enFlLA+LNm0cbV3HfHTZBC6J9XTTsAyrex+hH5y1GtWRAAr
	o0dYHdqcY1e330gYMyqMHpG5xuGjOJS7EwORdDtDfmTarCWj82cCOuTUL4CT4LskruhvTEVQR0z
	trFr9KkqPbl6XvOed+qaULwXtRM7IgrF7fMqCat1gEGbtrI1w0AIDLISx6NaflbZ0sudN8ru1on
	gbOugQifIo+3oE5aAc1CmUarkbY8WjvT6OueAlvfxqz/oNPEcydgVh+jRsD1LDfxW9VIgnXQgGT
	0KHFkf1sXwo1y+Y0e2UEMcg/1jU6uxa0zAuOKypXYQpNwbAVp4fcxEGZhCo8XmuzzTLX3O/c9Ju
	2ltY5+zOHByGGV6VFW60r3vkEgl/YWXLWlQu7UJt1gf7FzkCZFnCit4I09aHXDwUjCVHHpjCoZV
	ylOi6o18Uamg==
X-Google-Smtp-Source: AGHT+IGuiiKfj9Ky5M1IDQgKZkxwXGmuB8ci8DJvywCD6DA1DRBpsOavOAqbqIZxzYDFgjso4gB+4w==
X-Received: by 2002:a05:6000:2c0c:b0:426:d619:cac7 with SMTP id ffacd0b85a97d-42704d9397amr15295627f8f.36.1761147989174;
        Wed, 22 Oct 2025 08:46:29 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a781sm26171759f8f.30.2025.10.22.08.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 08:46:28 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 22 Oct 2025 16:46:16 +0100
Subject: [PATCH] perf dsos: Don't block when reading build IDs
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-james-perf-fix-dso-block-v1-1-c4faab150546@linaro.org>
X-B4-Tracking: v=1; b=H4sIAEf8+GgC/x2MywrCMBAAfyXs2YUkKkp/RTzksWlXa1J2QQqh/
 27wODAzHZSESWEyHYS+rNzqAHcykJZQZ0LOg8Fbf3XWe3yFDyluJAUL75i1YVxbemMKLt8v51u
 MycLIN6Eh/NeP53H8ADds20dqAAAA
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

The following command will hang consistently when the GPU is being used
due to non regular files (e.g. /dev/dri/renderD129, /dev/dri/card2)
being opened to read build IDs:

 $ perf record -asdg -e cpu-clock -- true

Change to non blocking reads to avoid the hang here:

  #0  __libc_pread64 (offset=<optimised out>, count=0, buf=0x7fffffffa4a0, fd=237) at ../sysdeps/unix/sysv/linux/pread64.c:25
  #1  __libc_pread64 (fd=237, buf=0x7fffffffa4a0, count=0, offset=0) at ../sysdeps/unix/sysv/linux/pread64.c:23
  #2  ?? () from /lib/x86_64-linux-gnu/libelf.so.1
  #3  read_build_id (filename=0x5555562df333 "/dev/dri/card2", bid=0x7fffffffb680, block=true) at util/symbol-elf.c:880
  #4  filename__read_build_id (filename=0x5555562df333 "/dev/dri/card2", bid=0x7fffffffb680, block=true) at util/symbol-elf.c:924
  #5  dsos__read_build_ids_cb (dso=0x5555562df1d0, data=0x7fffffffb750) at util/dsos.c:84
  #6  __dsos__for_each_dso (dsos=0x55555623de68, cb=0x5555557e7030 <dsos__read_build_ids_cb>, data=0x7fffffffb750) at util/dsos.c:59
  #7  dsos__for_each_dso (dsos=0x55555623de68, cb=0x5555557e7030 <dsos__read_build_ids_cb>, data=0x7fffffffb750) at util/dsos.c:503
  #8  dsos__read_build_ids (dsos=0x55555623de68, with_hits=true) at util/dsos.c:107
  #9  machine__read_build_ids (machine=0x55555623da58, with_hits=true) at util/build-id.c:950
  #10 perf_session__read_build_ids (session=0x55555623d840, with_hits=true) at util/build-id.c:956
  #11 write_build_id (ff=0x7fffffffb958, evlist=0x5555562323d0) at util/header.c:327
  #12 do_write_feat (ff=0x7fffffffb958, type=2, p=0x7fffffffb950, evlist=0x5555562323d0, fc=0x0) at util/header.c:3588
  #13 perf_header__adds_write (header=0x55555623d840, evlist=0x5555562323d0, fd=3, fc=0x0) at util/header.c:3632
  #14 perf_session__do_write_header (session=0x55555623d840, evlist=0x5555562323d0, fd=3, at_exit=true, fc=0x0, write_attrs_after_data=false) at util/header.c:3756
  #15 perf_session__write_header (session=0x55555623d840, evlist=0x5555562323d0, fd=3, at_exit=true) at util/header.c:3796
  #16 record__finish_output (rec=0x5555561838d8 <record>) at builtin-record.c:1899
  #17 __cmd_record (rec=0x5555561838d8 <record>, argc=2, argv=0x7fffffffe320) at builtin-record.c:2967
  #18 cmd_record (argc=2, argv=0x7fffffffe320) at builtin-record.c:4453
  #19 run_builtin (p=0x55555618cbb0 <commands+288>, argc=9, argv=0x7fffffffe320) at perf.c:349
  #20 handle_internal_command (argc=9, argv=0x7fffffffe320) at perf.c:401
  #21 run_argv (argcp=0x7fffffffe16c, argv=0x7fffffffe160) at perf.c:445
  #22 main (argc=9, argv=0x7fffffffe320) at perf.c:553

Fixes: 53b00ff358dc ("perf record: Make --buildid-mmap the default")
Signed-off-by: James Clark <james.clark@linaro.org>
---
I'm not actually sure if this is the right fix for this. Commit
2c369d91d093 ("perf symbol: Add blocking argument to
filename__read_build_id") which added the blocking argument says that it
should be non-blocking reads for event synthesis, but the callstack here
is when writing the header out.

There was also an is_regular_file() check added in commit c21986d33d6b
("perf unwind-libdw: skip non-regular files"), which presumably falls
afoul of the "which unfortunately fails for symlinks" part of the other
linked commit message?

So I can't tell if we should add the is_regular_file() check here too,
or just set it to non-blocking, or it needs some extra state to be
passed all the way down to dsos__read_build_ids_cb() to do different
things.
---
 tools/perf/util/dsos.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index 64c1d65b0149..5e1c815d7cb0 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -81,13 +81,14 @@ static int dsos__read_build_ids_cb(struct dso *dso, void *data)
 		return 0;
 	}
 	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
-	if (filename__read_build_id(dso__long_name(dso), &bid, /*block=*/true) > 0) {
+	/* Don't block in case path isn't for a regular file. */
+	if (filename__read_build_id(dso__long_name(dso), &bid, /*block=*/false) > 0) {
 		dso__set_build_id(dso, &bid);
 		args->have_build_id = true;
 	} else if (errno == ENOENT && dso__nsinfo(dso)) {
 		char *new_name = dso__filename_with_chroot(dso, dso__long_name(dso));
 
-		if (new_name && filename__read_build_id(new_name, &bid, /*block=*/true) > 0) {
+		if (new_name && filename__read_build_id(new_name, &bid, /*block=*/false) > 0) {
 			dso__set_build_id(dso, &bid);
 			args->have_build_id = true;
 		}

---
base-commit: a1d8548c23076c66d96647f5f6f25aa43567f247
change-id: 20251022-james-perf-fix-dso-block-ca1d8437bbc0

Best regards,
-- 
James Clark <james.clark@linaro.org>

