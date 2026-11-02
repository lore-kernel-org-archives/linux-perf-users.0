Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621755;
	b=WzDNor+yEkirHifjJbcR567CeSPIAGRkQHiq2vBVH9X4zMlD1cS35dLpO2P+JSwgn2A/
	 uPKOnTHrMNJ6BNNbd0UtVhdPGo+nBtNGy5PGTsMiQ58zPI9KcJ7cw31WiAeic8RloMeqR
	 O+POcWlwk5fRHcmmYmMZos6r8RVdmyNTHmyfqS+fmepLQc+CVH+2/2QfReTRUn0sfUURh
	 yY14njhOxTFPqJVmBCVyYJ7skSLMIzRWR0Kph3KPXR83UmrFMhidVVwKZYnIvV7Fhn4+f
	 8ciliajSCHzTjyDGR9Bhl7+AB2YqqTCJSr7ezDEmwJX/aNKu8KWcm8cK0881AGwpViA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621755;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=BWyhBgnl5ljVt2Vm8I0njJJDAjJXWTVLrBozwNDgUng=;
	b=P2BDN29tr03FijYfm0Wl/a8YVrqU3RAJbjLmn3e7rwyyjzpo+Ee23dFZN7ir4ZHOWawl
	 vMInC/TMJ4fNfZTLbkcwRgNC8qbkSNH9NKReUyGk0TTrm2OexxEPAYK6M4jJbVKu4fwRh
	 58RwW/QJa/WeNR+ZDVcPk4b/8Bhav0wzZXfdtVRdpQkOJCprFOz6PbagCVYIFm+8rjK2w
	 HOfrEzEdv3aLl/Lu8bY3+y3FS3oaHE/V3hGyYBLvzoYbyLq0f0/KrW9FzR+XhaFl5ajb1
	 bll6s5URQqqmotfwpZfgVptTP257sEHshmy/HxHLiMRZNILZ8FjGFstzz1erthNGArw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jYZuwm4i;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9CF60A5BCD
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 12:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A9CF60A5BCD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jYZuwm4i
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso33705155e9.1
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Nov 2026 04:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793621754; x=1794226554; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BWyhBgnl5ljVt2Vm8I0njJJDAjJXWTVLrBozwNDgUng=;
        b=jYZuwm4iKSkQfz8VriuCw5G+4HqM5DpQwNMCAhfmyMQBm+b9/ypIreMw1vR1AwMyjY
         njYOGwK91dVT1jVmUM2chqMZy8mC6qnwipKHRsCRFg9kc4qNsAo52O5d8Ld2/ArA41tj
         8MZiiaa4OSsIHDefjEt3MGzdBtSdafTuU6Uhxvrt12CM1sHS3f2BjinZXuYn0ZZuez4f
         2r9lIvkFc8HQ+a8JdaWJsIU2NVZOyf8hdpj+ctz1J5ObmH/LF6hWUndZeR7XvS7gKbYP
         K/2XA7u5r71NjplD8x8jjZZW6GOVIo4WzSqUT0U7nPeGmumvMeFnZDxmK2t817ImzKKV
         UFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793621754; x=1794226554;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BWyhBgnl5ljVt2Vm8I0njJJDAjJXWTVLrBozwNDgUng=;
        b=wJvwlpz615z7gBAy7m+a3M/meXQLNHDW2IGLSoAPO0z4+fXUCLoQF3Z/8N5Wazx9ja
         hn5oi51BA7ULM2IynIEbUpa1A+L0Zncw+urvvKHYwp8uCMFOY7IboZmZoBiPRl06y3/s
         pjwLkjw+l98vT/dRIc5IwJp5198KPKzIPM88cFvsiLPO+LiVkoHgf57TFGSQf+VN2rT3
         cmkXjc5iZBabUiD+hCRw29b2E/OMfCQ3IHFVvFEWLGnENwt25eMqRYZXu5riIixJ7WTY
         Q847Ao58fRzWkGnn8M0LWUWB+7yOJzC9XW7CB8LxcvrrB+DR2WtZXgIwDzExK6MA9BWZ
         QFLA==
X-Forwarded-Encrypted: i=1; AKwUvBxyAhKJmIIkEIrlsw/VmCCrvQUST0xIGNtdoDZdtfvMs9dru7feZbxTVUVAcC9bMt4AaVwJhh03mLedO9SiJNYn@vger.kernel.org
X-Gm-Message-State: AFq9FYKGWDFNoV+kUrLXKmLDGcRdmlxtH9fvUm8f5i0oLXHBc4JnA9lj
	ka7xnwA/M8op5TSfwjL3pIsiVmFDlzgLJ3Dr/7GMJvfijOjxb8hKGW7Ed0F+nDzhSOw=
X-Gm-Gg: AYBFou3QPT4m1HuyUDGXXMHeXhwiH87mKvSF0ngRGYF4fgKaJy/I0FYCXvjXCx6J0C+
	gdPFYHz5oS/BDuidT8AdfXpkjHTdMWqvMy7dal10lztdRyYYeZjKSb6lbGBJYXJ4yHaUH2WrBDP
	EkVn4sDABF9LKSFrEPODbWldprAGlKqYPPh44ODn2svv6/WsEinPsPjsdVRObkh8entDwXw2QJ3
	S49PuKiRpf0L4rouA4h7zWixvOqGAU3W4x4Gbjl6+R90VJXw9mU5+dz+rXnTzVqws4a2GusOpJ/
	UDgM0xj32oS0RsQjawBKF4PgooTQKylXd4k6gUt4tVG88I7ETHJ0+ZMGWGrKeaDjWyww3iCZgrO
	9iChbFR1cTTL4DE2VXriSihbE3Wrg3dYtua8MnoQr8o760VU6WWzMZUSMGjxeAu5GO2jxzoHS9m
	5g2WCd+P4kowv+VKjMUvr6xh5hLzNdSdwGb/cg1tvNKDeKoEC8XADzDbCTKrsPmJa11gielBRxm
	k2HM39D/SuNjuoFCLLUEiLjaQh7t7FWedtu6px2ognLM42y9fjpXVQrFlX98ijrZU/5ANpMjlNs
	JJWAlTQlu6zV48UpCx7tGT+UxbxzRFML
X-Received: by 2002:a05:600c:a103:b0:4ae:63e9:36a9 with SMTP id 5b1f17b1804b1-4ae63e93a86mr93551315e9.14.1793621753669;
        Mon, 02 Nov 2026 04:15:53 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf5b27e46sm434974855e9.3.2026.11.02.04.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:15:53 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 02 Nov 2026 12:15:22 +0000
Subject: [PATCH v3 08/18] perf cs-etm: Use instruction length in
 disassembly script
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
Message-Id: <20261102-james-cs-unformatted-per-thread-fix-v3-8-dbcb0c281b9b@linaro.org>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
In-Reply-To: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
To: Leo Yan <leo.yan@linux.dev>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>, 
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, linux-doc@vger.kernel.org, 
 James Clark <james.clark@linaro.org>, John Garry <john.garry@linux.dev>
X-Mailer: b4 0.15.2

The disassembly script adds four bytes to each branch sample's IP to
include the final instruction in the range. For an exception sample
whose IP identifies a faulting or interrupted instruction, this
incorrectly includes an instruction that did not execute.

Use the decoder-supplied insn_len to calculate the exclusive end
address. This preserves zero-length exception entries, includes executed
syscall instructions and also uses the decoded size for Thumb
instructions.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/python/arm-cs-trace-disasm.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/python/arm-cs-trace-disasm.py b/tools/perf/python/arm-cs-trace-disasm.py
index 5a7daf927bea..7cf0af5d2780 100755
--- a/tools/perf/python/arm-cs-trace-disasm.py
+++ b/tools/perf/python/arm-cs-trace-disasm.py
@@ -315,11 +315,12 @@ class TraceDisasm:
         #     [ sample_prev::addr .. sample_next::ip ]
         #
         # sample_prev::addr is stored into cpu_data and read back as
-        # 'start_addr' when the new packet arrives, and sample_next::ip + 4 is
-        # used for 'stop_addr' so objdump includes the branch instruction at
-        # sample_next::ip.
+        # 'start_addr' when the new packet arrives. Add sample_next::insn_len
+        # to sample_next::ip so objdump includes the last executed instruction.
+        # The decoder supplies a zero length for an unexecuted instruction at
+        # an exception entry, excluding it from the range.
         start_addr = self.cpu_data[str(cpu) + 'addr']
-        stop_addr  = ip + 4
+        stop_addr = ip + sample.insn_len
 
         # Record for previous sample packet
         self.cpu_data[str(cpu) + 'addr'] = addr

-- 
2.43.0

