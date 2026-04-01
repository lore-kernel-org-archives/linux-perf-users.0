Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704B52F3C1F
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 05:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775022741; cv=none; b=ndp9bzpUOy085KH/8m7tbXgeCMfpjujyaqcC9R8yoNPadtMjMq9otmAz2B42eSW977KmEa7fiHfyqDpQS+dmL6fLNLUi0FU8zIDTdKFXarhCF+hNjnYBACFovmI2C0oFFy26MXKgRY0ToTVByv27UjCkIuc/DxOb0wPcUWnE09Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775022741; c=relaxed/simple;
	bh=YXtKPFZbWWZBopwp0wtvWhgawI8Cv5FypUVRsO7wl+U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W6xNwR3bOVmMKb7xsQjGPD/JRfuyfAwlcHG6P3z9y3nekulcT8+AkByypc44lqF234+s6NVrviGvjXTNZTZTEPwsZ4f8b4Tx46IKaHLpm9C1OPkxVn/5YANmrofI27bB71IAqyzNzjrRLkNECCuliUpwpIMNQcueThV8QPNszIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=azhWjiRj; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="azhWjiRj"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c4cfe08c9dso15528496eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 22:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775022740; x=1775627540; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mXhmCfoDGbEzRy0vkOhlRcCB2RW/wzuPXoAXA+lWSZE=;
        b=azhWjiRjmMxSccVizr1Yw8vvLrtsyG8oSTEmryhfzLVcfMCwcdX/O53Z4l2F2YU0T2
         SDzymC63U5hqReW61+MQCB5oFxLaJ1gUTOZzC3q9+kflKygcCK4s0nguoD40ns1CpQ9Q
         bsHHF1LMqoHQBiC8hzGy2LPYOV2v9Aa3CyRYuKe1p3sve1VuGNj5N1rmXlxgE694o5Gm
         po0f52nRIPFhM8b+0+X7IvYQ3j2Flzm9mvIVfWWX9ngFNBv0hjp/i+NXb1bpFNpEyK1U
         hbMp3IBwct8Ol3WnjT8QAsbVkW3NPbVLbpHhLHcBXj1e3Gr35htjycEk/IezlUC3D8tz
         RA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775022740; x=1775627540;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mXhmCfoDGbEzRy0vkOhlRcCB2RW/wzuPXoAXA+lWSZE=;
        b=Ib7W9Uon4u/Y98leVqfDLpLq6ZOCLx5aJQqlwkWv+/uM5+ld+KzIe+pr5vI6hciuzM
         EwvtxxtjGG2PbSGnLBtoH6tmrmiTKJsUo8fbRq+iowxVRHqk+55m9GqtJDjiHwalSPER
         NN2Tcm8Ca4A+CjxQcYi6jIZhQLNVthVSGCGsoPa4iqz/AL2UdeYAIEJgRtEgVLqEYhoO
         E98A3HPenPrH2j8coUOmgEAeSe2f0nakfwtAwnM8/0gZn0xiV9y/W9rXim3ia/vijlFH
         uZSudD72o8pXoH+q3nB/JOce5XJsM5kyq/xuXFmuRsR4fb+DNp12VFPBDQHI37kGrl3Z
         F9mg==
X-Forwarded-Encrypted: i=1; AJvYcCUHMYXZLeYXNbTKm6IpUYF4OeyOaH10w2Dc2ehaZICbo8U+lFvkKQf1FNES0smHZKY7y6BJHxHa2mi58dmCUrpL@vger.kernel.org
X-Gm-Message-State: AOJu0YwP3sak0sj5U2Z/jJ8j4SBlBludoU6sIYj+u4/oCtmE5CypD/3F
	3QIdORN3tSjZFlF6/quZZwHpMtLvUmN+mfK/Z0tqKxNQXFqtExcA8SEHDAHt5Dj2UVsfhgiAEH7
	DZ5qaSGZHpA==
X-Received: from dybnl19.prod.google.com ([2002:a05:7300:cf93:b0:2c8:8349:e96a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:2213:b0:2c7:2cac:815b
 with SMTP id 5a478bee46e88-2c930986704mr1304509eec.6.1775022739450; Tue, 31
 Mar 2026 22:52:19 -0700 (PDT)
Date: Tue, 31 Mar 2026 22:52:04 -0700
In-Reply-To: <20260401055206.43187-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260228065953.3226283-1-irogers@google.com> <20260401055206.43187-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260401055206.43187-6-irogers@google.com>
Subject: [PATCH v3 5/7] perf ordered-events: Event processing consistency with
 the regular reader
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, ashelat@redhat.com, ctshao@google.com, 
	derek.foreman@collabora.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	swapnil.sapkal@amd.com, thomas.falcon@intel.com
Content-Type: text/plain; charset="UTF-8"

Some event processing functions like perf_event__process_tracing_data
return a zero or positive value on success. Ordered event processing
handles any non-zero value as an error, which is inconsistent with
reader__process_events and reader__read_event that only treat negative
values as errors. Make the ordered events error handling consistent
with that of the events reader.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/ordered-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index 8c62611f10aa..a5857f9f5af2 100644
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -243,7 +243,7 @@ static int do_flush(struct ordered_events *oe, bool show_progress)
 		if (iter->timestamp > limit)
 			break;
 		ret = oe->deliver(oe, iter);
-		if (ret)
+		if (ret < 0)
 			return ret;
 
 		ordered_events__delete(oe, iter);
-- 
2.53.0.1118.gaef5881109-goog

