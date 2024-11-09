Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9826613FF5
	for <linux-perf-users@vger.kernel.org>; Sat,  9 Nov 2024 00:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731112689; cv=none; b=oUQ1+BODXR5KoyY0D+foeribqMK2+NfZGwszjjDs4WtKCeex/3fwLoicg2binXJ9sYTF6Y2G2jZWUDIX8vUoiRd9c+aKiTHynpGstQmWb0ymhNGtNgC3Bk9vQefY3Vy6+LsvRyMBI3t26CPM11z0EhyVbmEn7qZ3UpavSpQgDh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731112689; c=relaxed/simple;
	bh=JR2W9BY58B7KI+DPucllOVM9yijzERRopT+DlqMeLCU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=JGYu/ZGnkmHShO/GmNRIENG3eJy8AeThYruUa98o/LcIvWqfJevygCjPm2Fe8/7NwqUW9/gB0cttlcmn119GoRkJ5Ms6NNiVOdVsp9nFYqaVl/hnFGd5xS+Mxx/FoOWhkd85+7kiZ1zMefyTX4GfA4LDWyEdyx3ncgaLbUAMh8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lz9ouNdV; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lz9ouNdV"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e293b3e014aso4259304276.3
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Nov 2024 16:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731112686; x=1731717486; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3SPWlc2lPTGFJEvFedKLB5LrjZb1UnFHbKvI0m+mSBo=;
        b=lz9ouNdVZcv2MhAZ2AalIAGKOMsk4P9C4qOkUYbkkITWMJQ1P+rSia7kf7ZH24/6zJ
         /VsQIDeyGzgxX5iyDYFjJAUHMehpEZ4W3HckFPZKN4ubOmmDWc8Q8LlocSrrd/9Mtz/Y
         +vzNYknawpOTxAbknjOOSTYBYIXQwpqqm4b92o47WuakiSGTZ09He5HP95J9sWzHynKZ
         /i99YdMn9tCNyhyJX8TGMNEFTYBkZPVQy7L3sxXYqY3j9B0AiIsfMjPWlTr4bGqt1+Ak
         +xAi3FdVYZUS0u84QQLlO0Z7S+WLlOYG6ZKeTIAniSngVm6Xj4dzVm3MgLskv/IwLS+d
         Jmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731112686; x=1731717486;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3SPWlc2lPTGFJEvFedKLB5LrjZb1UnFHbKvI0m+mSBo=;
        b=EZvvtvZQuR1IDi67wWEkGbB3cDXyBuZe0AiPBPyb6wzcfDW9QFtJk75jsby5Dxm/i1
         d0A/xYJAoDmugzqBaAHOLdPDGYE5o9XFTyS673am35Dy6iyNCfkSZjO6cN86rxhf9hGe
         GIvXH2CMp4vYtLPnCKprmrDk5Vals7mEmlz1i09blR71nal52zVKKfv/8rFZM+rgqjMN
         ePqNnNyE0A9Y7CGBIkR+oa2tEOKq4lcuWp0/xU8Z5vBUcs++siIG9vau92/YRT/ifWV6
         jQzZy53xjSYKkyhW4FDGioFVjMYSiTiGeEZpAvZW8/6sL/k4D05UXLFFh5n6yYoZCqR8
         JMuQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3W8fE6/wZHILMfXDG0cYJIbQ5JUs3HUAkds7KnZrlVlZbYyRqWRlnLo73Vo+mTYeHHph8wFMKWDIwhubbtLvC@vger.kernel.org
X-Gm-Message-State: AOJu0Yws6aMryYSEgTDE/Im1dQH4PKL5qNTaJzuU6A5rtFcSGuWyaNAH
	2SPMDuJ7htCuUdESaazWqzc+qZZP8uc9teN3VvjG5m0Bkb0QNO9v1SM7yMxUFaPQ0YeCT06zn9A
	VmdXJ9A==
X-Google-Smtp-Source: AGHT+IEbCvuNzznHJpTzjrrAOjr0V/uUsjUwc1//TkW/1cqMa3tVVHph1FyNI7oYtDyjF4CBOn/7+dGxx9S/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:6fd2:1e36:6d8c:7c49])
 (user=irogers job=sendgmr) by 2002:a25:dc4a:0:b0:e25:5cb1:77d8 with SMTP id
 3f1490d57ef6-e337f8ed8bbmr2910276.6.1731112686450; Fri, 08 Nov 2024 16:38:06
 -0800 (PST)
Date: Fri,  8 Nov 2024 16:37:53 -0800
In-Reply-To: <20241109003759.473460-1-irogers@google.com>
Message-Id: <20241109003759.473460-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241109003759.473460-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v9 1/7] tools api io: Ensure line_len_out is always initialized
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Weilin Wang <weilin.wang@intel.com>, Yoshihiro Furudera <fj5100bi@fujitsu.com>, 
	James Clark <james.clark@linaro.org>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>, 
	Junhao He <hejunhao3@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Ensure initialization to avoid compiler warnings about potential use
of uninitialized variables.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/io.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
index d3eb04d1bc89..1731996b2c32 100644
--- a/tools/lib/api/io.h
+++ b/tools/lib/api/io.h
@@ -189,6 +189,7 @@ static inline ssize_t io__getdelim(struct io *io, char **line_out, size_t *line_
 err_out:
 	free(line);
 	*line_out = NULL;
+	*line_len_out = 0;
 	return -ENOMEM;
 }
 
-- 
2.47.0.277.g8800431eea-goog

