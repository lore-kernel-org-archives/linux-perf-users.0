Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA2E3749F0
	for <linux-perf-users@vger.kernel.org>; Sat,  5 Sep 2026 22:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788648855; cv=none; b=gNzZYZuDQ5xcN4FUskD2dnF/NZW457oxWuzztl+e3nW0n4jPL3H+1+6M6HzlLaIN5qdOT7FKcJVWH3g8JZJLTdfCFL2mTfgxxg8oAe6DlVuTyPn0alcyhkAY//NblKX85NvpsUwRJRunSP3zffBM6zxsO/Ym7m44Cjl8HtzCioU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788648855; c=relaxed/simple;
	bh=0Yif8h3wRAA+zX//jWVlUkCu0tRyt2k+0eKhLSkGckw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=urhM3sjH64ob2l/xdjenTJrQYJUMeSTWt5TDFRyCzyMdDLJmMnm1Gw053AGJdEkG48sfuVdGjSiUbLqDYs3NCNyE/HaX6MsNzNQ+VGSYKDLAJTKZ3Lv3S9W0fwEJNJ1iAYeskQCizc8bflDLcEeq27dUI65oK+Lf7ARnsSRDJxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBitWIGv; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBitWIGv"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-86d43cdee51so28253127b3.2
        for <linux-perf-users@vger.kernel.org>; Sat, 05 Sep 2026 15:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788648853; x=1789253653; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=A6yPhsfs4XIaeoX4pT5JJrb0Czgqi1YEFf3B49wOqCU=;
        b=cBitWIGvdKICD9YF13h6m5pvkBc89ZB+jhxLgUvQ++i0skNJME+V8zHp7QFEX0jLPp
         jN1lSQoCkavVIcYE9AVjuPra+mIcVpTuFv/mX4EtPaD4+M8/damTK1/qA+77IQRhc97F
         RS8rIwqzZxkvwtljZtmu0FJDNB+Gzh6DXWPPGTtXhU5CWpgVlrlKVFvONdTY62GopFH+
         brux1uaU+RRgz0knX8/IfMKTIhVqpJJuqf99E8UAJ0fmOVcCN4n6hUTAC2K4qt+13svr
         2c9Xc6d1LGfZ7dkXA/5pUkVWnmRU3yLqGGyYyb9kahkNDLl1mLs719QWv7BHJK37XkDe
         aBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788648853; x=1789253653;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=A6yPhsfs4XIaeoX4pT5JJrb0Czgqi1YEFf3B49wOqCU=;
        b=aAOYvMzF3nnGk0V+Qyab6iVaEh3IdJajFHdGNtiBI/iesjugbYJ6RaWYsexy+uQYkI
         nhrGbKuWEkiCboFuKwFs5xtfF9pNWf9C7BkSUBWau1XfCZ1X8L/TZMAPPbeAmz16qE+x
         0TOrE4qbhKsErHrtYprbrvPxv/1JE/fK2++0TiDDtbOR1bkX7N4pQRtc5kFB+RawRnVW
         x/6LLFgay1NjKhkN0BbtCXqN9htFbn/5WGMOqX7UT5dJ/qw3Dar9d4AeMsOoKdrrKWBl
         xEXR8ZTNNnt81tHedPfQ4djycwYduolDhzhvmlTBgnKLjuhr9jQnuycAVuoR7K6sLpA7
         42rA==
X-Gm-Message-State: AFuF++lxnrrLZ7xOhJJrM+/MElhbykJo62hFzrhhqz+l9E/Pc1GThLEi
	BQtsH2W3JqzHo16T0SF+Zd0RblTGzLvvNnYn64m4jkjnq2kSt3urmFadH8zlOct8pDU=
X-Gm-Gg: AYBFou1vBWx2EBBT+WSS0wWZbRxnxaegQgqn8jzHHFm2UWXIBLHyI6oczQPOsWh5iL8
	foyz+xMJEGPRH/MlqySSfblv8skcdRtDFP6RcIdWBndal05xShLgN0kWr+AcY02aGhvVVInVpG6
	ish9oPrn1Keoz/fyIHxA9daUUzoY7t7mRq0Ny225YU9Lz5vxGkuWePABNm2BFiOhl2nPyneb9mq
	GxMbfFtZ6Q86wDb/xzwZOwHJJJ312+uxs/QQX+VhvieI1iLTZe/EKRRlQCXVV9/sLrqPZzsnROc
	xFMCPm6hQ++O6dBpB9+zWNi3nQZ+cVtK63a+9mgssSchbr/Rfen/GcEs/hmEivmNp7clKgUEs+C
	ZLrTJzRgcJ4GYLttS0TDxT5vHwKCyHEWNgJKztPL/ktUAw2QMeeG9tsbmPadsTgSnToqOoqWOSF
	d0VLBLCO93ICsgamgUHE22rztbCgdJtdOuAyHQ+LAEPrUWYnWg1vSfSJZL3v4giQ==
X-Received: by 2002:a05:690c:c509:b0:873:5bb2:6c21 with SMTP id 00721157ae682-8735bb26f1emr30474437b3.40.1788648852997;
        Sat, 05 Sep 2026 15:54:12 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714bb0efc1sm45516347b3.45.2026.09.05.15.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 15:54:12 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Subject: [PATCH 0/2] perf: Alpha annotation support
Date: Sat, 05 Sep 2026 18:54:10 -0400
Message-Id: <20260905-perf-alpha-annotate-v1-0-97380433ccb6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBswqciuEi3GnGogTDQiCO+et
 HyL/19IHIUTjNULkW9JcvqCpq5g2clvjOKKQSvdK6M6DBxXpCPshOT9edHFaFtD2g62d8ZAKUP
 kVZ7/Os05f8mlbOllAAAA
X-Change-ID: 20260905-perf-alpha-annotate-b49a2b8b6d99
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1920; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=0Yif8h3wRAA+zX//jWVlUkCu0tRyt2k+0eKhLSkGckw=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLLmzJ1kYHc1zH73zfZcsZ3JLy0fRTN05Xi487madl945
 qCz+cqKjo8sDGJcDDPFFFni1iuyzGrbsdTntPQvmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 EMjQMYqHyOkxaGQWF5emFummFRQ55OWXJJZk5ucV6+UXpOYVpBfopWWmlWRk5BcVpwKN0MtLLTF
 1dXQzMjQwsXS0MHOycDQ1cXZ2MnRyc3R0dnUysjQ3MXC2dDRxtTRn4OIUgLkm4Rsjwx7/43H7o1
 78tPO/Erl65xYND6/P/xd8vMIjv4dnzl/ePFGGf2Zvxd5Z8GtnGPf1vLt23b38luuVzSr5Z2fY/
 vk9qWzFUh4A
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

Alpha has no arch support in perf annotate, so annotating an Alpha
perf.data resolves no call targets and draws no jump arrows.  Patch 2 adds
it.  Patch 1 is a prerequisite for reading such a perf.data anywhere other
than on Alpha itself: thread__e_machine() currently misdetects a
file-backed session as live and falls back to EM_HOST, which silently
annotates the Alpha disassembly with the x86 instruction table.

Alpha's calls need a little care.  Only bsr has a real PC-relative target.
jsr is register-indirect, and its trailing operand is a branch prediction
hint that objdump prints as an address, so it looks like a call target
without being one: in a vmlinux built from this tree, only 23093 of the
213750 jsr hints land on a symbol, while 157204 point into the middle of an
unrelated function.  Those are therefore left unresolved rather than
reported as calls to whatever the hint happens to name.

Tested on an EV7 Marvel, both natively and by annotating its perf.data on
an x86_64 host, over bsr to a local function, jsr through the PLT and
kernel-mode jsr.  The two hosts produce identical output.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
Matt Turner (2):
      perf thread: Fix live-session detection in thread__e_machine()
      perf annotate: add Alpha instruction support

 tools/perf/util/annotate-arch/Build            |   1 +
 tools/perf/util/annotate-arch/annotate-alpha.c | 185 +++++++++++++++++++++++++
 tools/perf/util/disasm.c                       |  15 +-
 tools/perf/util/disasm.h                       |   1 +
 tools/perf/util/machine.c                      |   1 +
 tools/perf/util/thread.c                       |   2 +-
 6 files changed, 202 insertions(+), 3 deletions(-)
---
base-commit: 9f0346dcbea363787186c94ef94dd01aaa215afa
change-id: 20260905-perf-alpha-annotate-b49a2b8b6d99

Best regards,
-- 
Matt Turner <mattst88@gmail.com>

