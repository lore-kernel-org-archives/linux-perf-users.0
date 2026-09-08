Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B699354B1BC
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 14:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788877662; cv=none; b=W3AZw2rZ5ooWzukLbu8JR4/C56KEsq9n3xCrT9NWwgLy3E1FJLkqvEeBBG0ictc56abD1x7KaslXA9ucF8TPS8QePhSjyVpUZG4jzVYtNoASAGoPkFcCx2dpUcBYmi8HK8CrogFyVVJn/PHPNXq/fNZnr/nsb5Ds0DlhZ5jMhFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788877662; c=relaxed/simple;
	bh=+TM+zYeX3ygRQvHGcTEUljLUIwOHDrWNq9lU7U+08kE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HR1ly2U84+IgbqGnQRW4pR0KtFZ11GLuv0uUvC43a2fgklFC2vhzk4IS97H2tqOoWr3CLgd1KoIMGhfAzjykbdmNJgh2SKIq/75VBAE0y5MdoO8kD+MXvVjQblLw/niUu3euIfPUFxcLnw8rMcVxSIstgiVDQ/NAb0s+MozqV/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8qKOnm7; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8qKOnm7"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-467f09c00c2so1302044fac.3
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Sep 2026 07:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788877652; x=1789482452; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=a5Kv6cT/AwOHxG8+33WPtCAWS/EjeBTh4gFEfyRtB4M=;
        b=W8qKOnm75q05XMcH+6b5jjgBuRfBgSKR4a8qOcw/VqjP/ITIvk5k06HEYgtNEIeRul
         jGHfjT56yGo/pW0YnpaeUQ6R3JFmY6K9Q9/INLt5D+M0ckXvCPH4EaE5/URN7NahqyDK
         fLs/OlDH5F5joqHZ3mRufEBVMw/QJNsLnZw5TnwXdwCZIlFqCa+BsWBXB+9XEzpFd60A
         BrzLcNsSnERLKFCWXpwsZ0mm7qj6XAJ6Tvr3kfwYnaTHi53tduclukfERe3qjqzVntbp
         iltbuAMBzhduaMKYXfp3KzTTZWO3NBhC4k1IQvZo6GbZLjKCUj1Gk0B3YVlz68C/P/1U
         QFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788877652; x=1789482452;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=a5Kv6cT/AwOHxG8+33WPtCAWS/EjeBTh4gFEfyRtB4M=;
        b=rW7yrkjGwue8rB4gxEBqqvvclvKRc6AOutNq4a5kPW8CmVyx7QuLpr+DUqeezYN+qC
         CSb/+5nysD32894aug5IJ/MzfJcoPQBMc1cvs6TPNigI1i2qEEY2T9Q/BO9wedTGfAy8
         tK/pViS1xwsrubssdUzybtD/VajG6/pAcGTCW9haDdR5IzkLzNoTrxJmgVy2HHAIxlBz
         oMhq/x9YAJnkH/Qpxd0zTvpbZcU6McocFFE6dHIzgpDlsM2G1yaFq/VRwoD8TLtMpeq0
         Hm4TAqqiMZpUPcEglC7eDsU5OB98mBNyJDIc0f07WLyesI4xEWhkkZJ1N+8b7aPay0Jc
         pjmg==
X-Forwarded-Encrypted: i=1; AKwUvBwo1KCF2oi6vOuPUaks3D4chGUOOjNpwa0I5ig7uVPUTJfwONR8gdnkU6umpWpjvv3yoPMMFw0jlk+9UEiA9KDn@vger.kernel.org
X-Gm-Message-State: AFuF++ksmAB6QkWinYozZ/BaqC+LEehVFuKRWpZrl1F8mRO1nFxwUEvr
	KFKDk9VqM8OgbqXjMCdurSLdm765WJdwgroDpIEx2IaihQzqwwzvS4JL
X-Gm-Gg: AYBFou1atTXHw+/gGqzQd+8FfpYjIWCS+EP+eAuHMSqM9s2pGEO1BJuzQBukGjElnGa
	cS8QVEeB77+/lKNrtDp2hLkT2NE2cVjNJZ6jU6xsSacLrddO36kJ8xTKxpBG6HSn0H/No7suR2H
	IxrzimlD+NB8LOUstm3nFdIG/mrKrDy6LqoEC8YOvK0vZ+E1w3kftWjJzWL0C5iK/sQqf/b19ol
	L4PoizZMWr4hUi0LlKPOJCTJ+eJDJYn6bD4/7dBAp4g/G1+5pS1zsz2i6mGlctzeP4cODkk0Fpv
	dhPil12c+bt7f2xDdeYxl2bwV7zYRxI9uS77Si7pmAv9+Adj0npHNouX6VwJkJgQo4kfnS4EcoF
	2tfLDAFkzqwdp+ifbPMlH42Hma1qpjf8khAKBOAz8aeOdwaZAbMMnYClJy5wmYghrmFGX2zMe1V
	+paNXcDLXDmqiGwh9uycwtzIpwdmyBJWcOce63RjT4W1E45hSaGg==
X-Received: by 2002:a05:6820:218:b0:6b7:46e9:9703 with SMTP id 006d021491bc7-6b746e9a293mr14206611eaf.51.1788877651736;
        Tue, 08 Sep 2026 07:27:31 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7fc68d5ae2bsm8456663a34.3.2026.09.08.07.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 07:27:31 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf-next v3 0/3] bpftool: Improve perf counter reporting
Date: Tue, 08 Sep 2026 07:27:09 -0700
Message-Id: <20260908-bpftool_cyles_per_run-v3-0-60e86f325c35@meta.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD0boGoC/4XNSwqDMBRA0a2ENzYln2qqo+6jFDHxpQZsIokNi
 rj3gpN2Ujq+cO4GCaPDBA3ZIGJ2yQUPDZEFATN0/oHU9dAQEExU7CIU1ZOdQxhbs46Y2gljG1+
 e1pJXtTVaMq2gIDBFtG453BvoyVKPywz3gsDg0hziegwzP/ofO3PKqVK90tZIw6ry+sS5O5nwP
 MAsPkjNxC9EUE61KXt+7npmsP5C9n1/A/CaQMAIAQAA
X-Change-ID: 20260827-bpftool_cyles_per_run-93169fcb30b7
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com, 
 memxor@gmail.com, qmo@kernel.org, linux-perf-users@vger.kernel.org, 
 acme@kernel.org, namhyung@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788877648; l=1346;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=+TM+zYeX3ygRQvHGcTEUljLUIwOHDrWNq9lU7U+08kE=;
 b=zxP6ytb5ElqNaFXIzMX7miGvIJ4epfwVee8pWS84746ePATW5qUF2/Ob0FFeehhmW/VtT108b
 2I9ZfcIpWPcC7jxcP3+ZqfEaAq38JkEgVhSSPhmU6LufvCFmUDGe0EN
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

Track valid snapshots that have a zero counter value. Scale each per-CPU
counter before aggregation. Report cycles per included program run.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
Changes in v3:
- Keep the JSON value field raw. Add value_scaled and run_cnt_valid.
- Use the same CPU set for all metrics.
- Move snapshot state tracking to a separate patch.
- Link to v2: https://patch.msgid.link/20260902-bpftool_cyles_per_run-v2-1-bc5d14ad0ce9@meta.com

Changes in v2:
- Scale all counters.
- Use an enum for metric indexes.
- Link to v1: https://patch.msgid.link/20260827-bpftool_cyles_per_run-v1-1-77d7bfc3c065@meta.com

---
Mykyta Yatsenko (3):
      bpftool: Track perf counter snapshot state
      perf bpf_counter: Track valid BPF counter snapshots
      bpftool: Scale counters and report cycles per run

 tools/bpf/bpftool/Documentation/bpftool-prog.rst |  13 +-
 tools/bpf/bpftool/prog.c                         | 159 +++++++++++++++++------
 tools/bpf/bpftool/skeleton/profiler.bpf.c        |  25 ++--
 tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c |  26 ++--
 4 files changed, 168 insertions(+), 55 deletions(-)
---
base-commit: 3fa3128887a4df6057c543aae7c5c7fd2ed41f12
change-id: 20260827-bpftool_cyles_per_run-93169fcb30b7

Best regards,
--  
Mykyta Yatsenko <yatsenko@meta.com>

