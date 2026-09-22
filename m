Received: from mail-wr2-f28.google.com (mail-wr2-f28.google.com [74.125.225.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25D7488D97
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 21:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790114170; cv=none; b=j2cGY2W0QNrlNUcRwVrXokcIDTsn5kHITo4W+Z8ZTkFNv0FkJjwlZgI9t6xo+GdXzy22eZf4Iki8tE2Ncun5+Y+yu6G4UpddPZ2sHfMjFFk7s9pLnSVx0s38wrFfHJSvlLLT5cqy/xq/1jPGIt75XUS17naWfcCgoH8RrR5GB/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790114170; c=relaxed/simple;
	bh=/zbhuXWE1WlTQdG3ZgKrd6QNK2ykNmsb80+FJXV8oak=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c0kqP+KWxKDbvHHtYDLfWFBM2zQ1esxjHPlX3GisJUrwGbWD/dXpiB0wu5Mre40CqZLBPkSL43NfYABbNC7GieHkRXQQZmuWBuodO0nl69NtOTXktFqy+cJsp35UZxKdfYVjfnwDjfRlVBps/3VUYY3NIsNZQkVGVB+Pm4DggUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVXE6NpH; arc=none smtp.client-ip=74.125.225.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVXE6NpH"
Received: by mail-wr2-f28.google.com with SMTP id ffacd0b85a97d-485b1d2874aso291277f8f.1
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 14:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790114159; x=1790718959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/zbhuXWE1WlTQdG3ZgKrd6QNK2ykNmsb80+FJXV8oak=;
        b=QVXE6NpHVHu85g79U5z1Sb8a9IIPJ+t8+LFNQn74fcA5yjmSDap19VXtzpze6BSuRJ
         TR5aUUn89AxLueiUNa99kR+wmQ7vttvJBuA+dvLlwn/erWkWfb44K9VFy1xTQtdybcjG
         3HE7jgAgdGv+KYygybDbTfI6eNSl+fL5Kwj3bAG/P9u+nO+ssQtQdH2JhpdHgeuH3fnF
         B5DsAlf5l2X0mGNtTEA431lYuciTEOJ3j5I4NsNEaxemWdA2iPXS9NjB1PEDLmmLBnGN
         uHQeAFWxt8rvoAKvZOjr5WnY8loEfFOUKEskGPNKU4lwYFx4GarIZp32Zqb1kLY5P+mV
         wraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790114159; x=1790718959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/zbhuXWE1WlTQdG3ZgKrd6QNK2ykNmsb80+FJXV8oak=;
        b=1mf9EogQowEpwQiClYflfSHHAyQHo/lRW/Wt/uAVCOwLhV0YKFxjlwDE1+lhmtQgh+
         iHqCUPMNtsxc+YYoUsiesUFZe4Tj0CMoR/q3Ux0w5uyNP240ph0tjth1v6KhNauq2hbw
         74t4ekdGvsWm7Z0ZJfbckIIWC0gI/6d6IxmfxqCJ9t4DzWLlITkEVsWROUhHejAHDhMU
         2FdChEWkkvaq89VBwJYY5ZKPLasyOKRGUAZwDFInaASpIq5lNHTFC4EoUgK9Hh04NTKB
         DIMzN9LPpnEn1wIZyBnsrBqH3kqdWZDi0DchinEdeUhNX/FO/FKQiJjAYnscUbVr4sGE
         g5dg==
X-Forwarded-Encrypted: i=1; AKwUvBwpnlcQKWG9dIOxIuaBnYDU6TKDg69AmJSmIts2y3eIgjhS6CtdaYw/e6Tq4AAVDsvDgImh7t1A/lIFV3UFsIZs@vger.kernel.org
X-Gm-Message-State: AFuF++lNekGvK3idH7hb3qgQLuuEd1WPTVkKqpW3F/Ecohad/XCmLcej
	jq6j3m84+rDGI8JayyUM/feh0dmBO686Y61qV0s/9BzcQydk7Tq12AZ9RwmO87GYiGY=
X-Gm-Gg: AYBFou1e/Cy2+q3sz+PcP+EynvhqGNwFr6RJZtPpYUDA++aJtJqIuWmTUxUqOxrcKll
	iPnb60lsuoz4LC2i1SRMPaY7bHzEMHBoJE2qLlHddBisK317zbZbaFSNafJ8ox9KyMzim+5BrSS
	UZKwtufsgZ4fRmh0QrPRb66rpaNnwzWSqT8msJFAb6xbxTI7q7q8T0HV2t4kF9hSdZEdJzvEjsc
	A50DfXZ8KmldyQkAo2LHDKIpDfdu9kDqjG9OZdv7rVVDF8pHpmFYTFyXxbVQLY76RtGWWf9tCWm
	69YscuHtaaWWkL+raViawSi2Spv4X3fPa10ThtM62dJ8y8qhuOU1m4If1xsEjKZbcSWPEVMpB1h
	j3zB5edR27HVRN2Oj08u2lUn8Y/4mDDgq4ye2nAbI+JvfdltPpUX2BJfFc4+Jh/JJQzQkYKXxm2
	5dSoyyXTAiBZ+P+9nIZ634Xl747zO/XQ7sPLrSFJX2xCADjOBDOh+bNIyp0T35a0sy25gUpUyFr
	/hzmvBOQsKzdqV/HlBKcN+gsXzt59jDoUF7daZk
X-Received: by 2002:a05:6000:2dc9:b0:487:27f9:832 with SMTP id ffacd0b85a97d-48867095903mr1279068f8f.39.1790114159022;
        Tue, 22 Sep 2026 14:55:59 -0700 (PDT)
Received: from christian-ThinkPad-T470.. ([2a03:4460:170d:5700:7168:5af1:a975:cf85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488682668e7sm1789647f8f.4.2026.09.22.14.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 14:55:58 -0700 (PDT)
From: Christian Melendez <chrismelnu@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: perf stat: worth documenting task-clock/cpu-clock in perf-stat.txt?
Date: Tue, 22 Sep 2026 23:55:48 +0200
Message-Id: <20260922215548.398541-1-chrismelnu@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Arnaldo,

I'm learning performance engineering and ran into this while playing
around with perf stat. perf-stat.txt's TIMINGS section explains "time
elapsed" and "user"/"sys", but I couldn't find task-clock itself
documented anywhere, even though it appears in the first command
example, as the very first metric shown.

This apparently came up unanswered on this list before, in 2013 and
2015 (2015: https://www.spinics.net/lists/linux-perf-users/msg02405.html),
where users asked about cpu-clock too, without anything ever being
added to the docs. Would it be worth documenting task-clock/cpu-clock
there? Happy to send a patch if so.

Best regards,
Christian
