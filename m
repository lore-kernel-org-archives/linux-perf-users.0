Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672351;
	b=wVzORjS6G/ch+5SsdVqTi7lkoVYjiKkPkMsmUsFXYkTbKGNHMRLr7Wt7Tdhbi/wyA6Lt
	 AbEy/JmB5WSW/A1+SRLIS84eypuARtg0hwQtEag+h+qxANN8aoU2h+fJMo5gT7pj5GaWQ
	 bBotyulrziiP0r037j3gVjgvISeekW++DotFIEQVwcH6XdKV4H0da4d97QNphYnN/YPUM
	 82hq9psxULwoHb7EEFA9qAT8wzCzpyiZU4Tz000MJfr7oPH6q6adBlA4z2qD/GWFigh2D
	 Elk41B09/2r3+24liRUDJAPyqQgJEafshKUQ7t3mSMTR+CiIjXUQKjcy+TNIi0sshWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672351;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=VyzpExeelLAR9HxeoHhIVWRIik0hjXGnpC16hisKM74=;
	b=lbbcckHvFk5xOCMHt6rVKL3uq5MiI7FdSdayjKCUvaOG+9f3sHc4MP3C+4D5vC8lhBLg
	 w+iNcX+V42OHq1TSD9XRu3/WrwE9hXVGvQs0ofRd6Ge/L4VwaF9LqTmMOysgoSEF0Pwjp
	 2gqs5wIzkhruPDOO9Fks9W86Ezo+zGAhLGHI9Nn1jsv6FSbb9A8fXeqhVCYw4AqflqETx
	 Yw3j7DOa8Y34JFC0b/EwjAgz0Qzn5OpqRr1uPouY9EDySs/aGpNNVJUs8VxAmdLecyi5Q
	 I3wb+R3GkNbbxRVyvEn4+zMz2L0rbxroYqITJD7hL532q2sQcKIsOIMNTGBZ0f/auaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YPG3aHZN;
	arc=none smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECCA606A324
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 02:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0ECCA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YPG3aHZN
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8b0dba37a7fso32768507b3.0
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Nov 2026 18:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793672350; x=1794277150; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VyzpExeelLAR9HxeoHhIVWRIik0hjXGnpC16hisKM74=;
        b=YPG3aHZNwjTy7pqWgk/wgmpwgP8ccjFKXRuzkZWDSlc/gqhvKcBtIS9Atqu5CKZc8F
         Qxvs6lhqCkdN0GggJRuirt72jv0IiyAZ4U+y+zTqGyQDViGkq1Nf8k1jUpeNm6iTxWlZ
         hqYAMYVzt5kMk4XC7lhC9YBv2eURF/zTxz29+wj/9rDRikIYgw10piczw3R+QqNZV07K
         RZ6JLQUMZhwKRP6h/vx2jNaIm02X0YWj7CQ5CYmI9E81EL5bU9zwuUn7YcQN/VwBmJAc
         Y7zYKVyxX2Hw1I92lRSVsG0sdToJGEF8k8lnnqu6Y/d5SA6uW8VbLr3yX5PGVKdjMDif
         SvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793672350; x=1794277150;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VyzpExeelLAR9HxeoHhIVWRIik0hjXGnpC16hisKM74=;
        b=NAwoWD5m3v/Yf/FIPFTYjdZzAKdMEPar3zmQUD88raqhi43aDyLfSElfcg1cM+gEsn
         A3l5veVjvz6ojg+mzZZaKZqO/q11B0Vn25IBfV4OeAqIc6k5SIEO2jTT+KXLiq0oVUAc
         kouokoCcxxj259P4UJOE80i8cPf+fFfmy9AfSpKZ6UN2JjmLZdeTlOwZvs6SUOHWxspy
         OYe+94dtDZeI6g95YccPixiXytmdrEwuRhU8RVA8LEbxmHXBwI6/EVLFVBr00HmZov0N
         0n8NFaLLAQD/GQGnODFxTngS9Xm9ECogDXSGOL3D284yLzFmTGMEB84eEAHM97opEP+6
         odvQ==
X-Forwarded-Encrypted: i=1; AKwUvByGZw+eA+qvKH6sevVV6t/snhg2jBs92mh42Ytahp76EnngtbYsmR3Bi7Ziictikbo+G8B8Ev+KmwNXEUQsO6WH@vger.kernel.org
X-Gm-Message-State: APuU4Z/sKhqeYGu9x7o+pOucmx7ae+dDDgil8nKkrQUpZm8K1417pW56
	59AHdijsuRK6AhQrl6jSUfIBRz3Qrt8aU6Uar0IgTghFLsWW0NVivjzK
X-Gm-Gg: AYBFou3BIFiGZZ5xBVxWynq6AWUKtjK3QiAenX7/qc5mP1Hxedjblyy06t1ZoI/v9Dk
	dAFOFiIOEsw5x8Ol+nvDFmC8LGsVJDF84E+bYuHrPZZ9+3TjXnakOnXFJ+5Wm9xUWD90v6M/4NY
	yPytorAv5DLgA9jlyjGjB2l6qId/FBIkP8CkmHDLoEVRkTx3vOpf1dyVelq5FJv3OMdgMGalWrD
	arSZ0Qbr6k4tR2WX6R7a6C+3CP2XCxGL1TVNbnRbHEbTrT0ILRDRY6oXSkyVFj8KJ+4cmpCginE
	4Dr+1onDo9pSkGJMiraDLbJLdMHVkHkr7kAgIhM2QkDlw4K6Fw5cl2NRXdcL9fUXZaQFqHx3yin
	Q1jtymFAw12nCbZ/WQHlvhLCZmFKjCfGNPRIqZ2Sxhgtoxd2fcZf/qVyy9LCAYZrBpYUfN8J03q
	d4V5gQnX31xi+BEJqHWJ1YVQDk2xlCYVTymk40vz00pmW2hhVzq1BvrseLq8TwrwnLKNID9EsHi
	hOO6qbMLrT33s4Hgo3kK47w/vmvUwiFwqkI1hIrDWfZDF2THSrUwmwN8614YvMmAxRgkIwL/cKL
	HD7ecSdq9NvAVsTOAT0xlzSe5cwoTEezJnEOXKCnrQHW908zT64lrzGDJs+mcngDGsQMxf8OYtv
	jiywtwN3h/5CtOg3e45FHeLKB5JCyMXk=
X-Received: by 2002:a05:690c:397:b0:8b0:c673:993c with SMTP id 00721157ae682-8b2b66ce40fmr68322287b3.21.1793672349957;
        Mon, 02 Nov 2026 18:19:09 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b71b70fdsm62693447b3.43.2026.11.02.18.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 18:19:09 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Subject: [PATCH v3 0/2] perf alpha: Decode ProfileMe samples
Date: Mon, 02 Nov 2026 21:19:07 -0500
Message-Id: <20261102-perf-alpha-profileme-v3-0-4bf6e1dda733@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNzQ6CMBAGX4X0bM12awh48j2Mh1K2soa/tEg0h
 He3xQsX43Gy384sIpBnCuKcLcLTzIGHPoI+ZMI2pr+T5DqyQMBcARZyJO+kacfGyNEPjlvqSBY
 Qb2VZkUYt4uvoyfFr015vXw7P6kF2Sq60aDhMg39v3Vml3Z/ErCRId8qtKnVRA6jLvTPcHu3Qi
 ZSYcSfR8EOCUVJaQgcVUI64l6zr+gG7DQA5DwEAAA==
X-Change-ID: 20261028-perf-alpha-profileme-8010299be323
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: Magnus Lindholm <linmag7@gmail.com>, linux-alpha@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3404; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=WpIs83CyacYYndX7yUegp0rf7Gr25AUcEjh92rXYCVc=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLJeusxhzuF7GlyqHTP1uenxwxFNBoH/jneVmC+TLHqXU
 xLJdORkx0cWBjEuhpliiixx6xVZZrXtWOpzWvoXzBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn
 CGToGMVD5PQYNDKLi0tTi3TTCooc8vJLEksy8/OK9fILUvMK0gv00jLTSjIy8ouKU4FG6OWllpi
 6OroZGRqYWDpamDlZOJqaODs7GTq5OTo6uzoZWZqbGDhbOpq4WpozcHEKwFyjyM7wP0xyusox4S
 ebaqbUtT+UuzI54MJ258dc1/7su9qzcU/2VGNGhoPxG7M/WM5KX/7f6mlGu3bMi+Cu+LnpXY/Ob
 rmUdlD4FRsA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

The Alpha kernel series "alpha/perf: add ProfileMe sampling" adds
ProfileMe sampling to the Alpha cpu PMU. Each ProfileMe sample carries
the profiled instruction's PMPC and its I_STAT and PCTR_CTL status as
PERF_SAMPLE_RAW data, which says whether the instruction retired,
whether it trapped and why, whether it was a mispredicted branch,
stalled before map, or was killed on a wrong path, and what PCTR1
counted while it was in flight:

  https://lore.kernel.org/r/20261101-alpha-profileme-v3-0-92d511b5a044@gmail.com

This series is the perf tool side. Patch 1 decodes the raw data in perf
report -D and perf script -D, as is done for AMD IBS. It copies the new
uapi header from the kernel series into tools/arch, so it should wait
until that header is merged. Patch 2 adds a script that sums the status
by symbol or by instruction, in the style of DCPI.

To try it, with the kernel series applied:

  perf record -R -e instructions:p -- ./workload
  tools/perf/python/alpha-profileme.py --pc

I tested this on an AlphaServer ES47 (EV7). Sampling a loop whose
branch tests random data reports that branch mispredicted in 21% of its
samples, and 0% with sorted data.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
Changes in v3:
- Patch 1: silence -Wpacked around the uapi header, which breaks the
  build where __u64 is 4-byte aligned, such as sh4.
- Patch 2: only read raw data from cpu PMU events, as a tracepoint's
  payload can pass for ProfileMe status. Thanks to Magnus Lindholm.
- Patch 2: print a table for each thing PCTR1 can count, so that mixing
  events no longer averages unrelated values. Thanks to Magnus Lindholm.
- Link to v2: https://patch.msgid.link/20261030-perf-alpha-profileme-v2-0-9ce2f0b0e622@gmail.com

Changes in v2:
- Patch 1: copy the raw data out of the sample and convert it from
  little endian, so that it decodes on strict-alignment and big-endian
  hosts.
- Patches 1 and 2: follow the new 28-byte struct alpha_profileme_sample
  from kernel v2.
- Link to v1: https://patch.msgid.link/20261028-perf-alpha-profileme-v1-0-f46c1938d001@gmail.com

To: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@redhat.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Jiri Olsa <jolsa@kernel.org>
To: Ian Rogers <irogers@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>
To: James Clark <james.clark@linaro.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org

---
Matt Turner (2):
      perf alpha: Decode ProfileMe raw samples
      perf python: Add alpha-profileme.py

 tools/arch/alpha/include/uapi/asm/perf_event.h |  31 +++++
 tools/perf/check-headers.sh                    |   1 +
 tools/perf/python/alpha-profileme.py           | 172 +++++++++++++++++++++++++
 tools/perf/util/Build                          |   1 +
 tools/perf/util/alpha-sample-raw.c             | 150 +++++++++++++++++++++
 tools/perf/util/sample-raw.c                   |   2 +
 tools/perf/util/sample-raw.h                   |   2 +
 7 files changed, 359 insertions(+)
---
base-commit: 4626d370ae89b8af4d46a45372b269f926ec662d
change-id: 20261028-perf-alpha-profileme-8010299be323

Best regards,
--  
Matt Turner <mattst88@gmail.com>

