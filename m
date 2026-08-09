Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4BE1F16B
	for <linux-perf-users@vger.kernel.org>; Sun,  9 Aug 2026 05:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786252705; cv=none; b=g0o1jf1PLj76EYfN+66EJcEjrrslONAfZq6kW5SZlxBqmwT+xejYE0vvEI4dJJgxi2LM32+ViSxw9X76LSQw2LS034eiSdHDPHlPcrXHVF7YZSgVkZ494NqGznMvjD19qjzwpa45r99jOaeowZZfd1erM5uA7I6brIvYMUlpWkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786252705; c=relaxed/simple;
	bh=1f4SAfL/iH3VUl4bBcVnrLTKhHsC68BlN+4jz3pNqW8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eaMiwrGJIuN0VuVK1An4aluIt01C1Ys7wqB8mSDIox3DKzt2eNpY+vqgwaJ/ydlx8l8oJokHgLTyE6QobcrfdkAUUBVtIDsRT0Xugg6v+wGmEtS3s5teOotIl+tyLAmaZl/W4ZCRQ46ln8y7EzZhGV++yFHTUtgn3nIJ2lZ/a98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lxbt1q7B; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lxbt1q7B"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e8fee6af3so995508a91.1
        for <linux-perf-users@vger.kernel.org>; Sat, 08 Aug 2026 22:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786252704; x=1786857504; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pSe2XCOqapMcKw3TgudQ6h4GJ1YS3LXbzUXugkTsEr8=;
        b=Lxbt1q7BERM0mDmap8TvyjL5RfovJhfVkQDLkSPbg27B/kr026SEWL4DHshVH09HnK
         ZXE6av7bfJ9I0WVPtv+C7r45aEHUM2P51yLBmq+S6e1XVvTRof2Sw5pq1CGTorH7ZaF1
         cYdRbwPz8H7p+ISJrIrktg5V39VhYYqPgVcwJXYyzJSUNbQ8Qhrb4ZYck5Ov67Tvf2lx
         OgLd3FnvoOLYEBVe0z4LZxQ3tMjv/51jcEgz2gm23zzC7RVfiWkeC0iGj7kthCyyp78x
         1FB/au+HJcwjJ4wWxUdgLQrRkcsnQe8dE6iLX6ENdlbmoEbEcArd9cOHwQCqerhGD3m7
         9dzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786252704; x=1786857504;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pSe2XCOqapMcKw3TgudQ6h4GJ1YS3LXbzUXugkTsEr8=;
        b=Ps7/u/vhTKLSZHGa7M6OUmZ4aRP01Bktb8qk6rGZpmOdYKuVjLp/hOi+57ebTDyLHM
         nM+jU1CMVDupsgKXYSRMXgZ8FDZvc9qbGebzFzslx66NijQUPIItX6WXr7Cv+3pAbnlC
         lHqlOO+auK+Ku2RgBl6ksH9cP17pUjp6hy0+MUTnu2apXTAYPR1Qip16tkQS9l8Xd/AC
         9Zga1D9SF8QzIwjUWDT5sWAkkNAJA/QGthREEIASiIV4127ucyz8v5PQWOD8PlgoLk0O
         cZo7EzzzQRI4x258NSTuVm8TuHBw2YZI9NLpA+Ta9dBRHyxm/wie23L41otZSAdQ1+ep
         UWWg==
X-Forwarded-Encrypted: i=1; AHgh+RqN1A1rw1ilvAa0lC+za0rhRBhR9IRnMELFiBR3TINRQIxok2I9xCVC7fjLHP8yYm58ovYznGSgeseIhRLxvxlf@vger.kernel.org
X-Gm-Message-State: AOJu0YzG7xrcCgIg8hJfrvn2r4BGb5yfOCH0X31000Clwjwe1dwTqN2S
	WVzdYp5Y4wKwK06u/q0Diq5riKez2Qde4Gee9Uuk5UCLrr8Ozch3DFgxsOmguhB4jTkXO1xWb2d
	9/Bs8OQPUhg==
X-Received: from dled17-n1.prod.google.com ([2002:a05:701b:42d1:10b0:13b:2a58:e5fa])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d885:b0:381:973e:fa08
 with SMTP id 98e67ed59e1d1-3928242e8cemr11025060a91.18.1786252703515; Sat, 08
 Aug 2026 22:18:23 -0700 (PDT)
Date: Sat,  8 Aug 2026 22:18:17 -0700
In-Reply-To: <20260809041638.2402705-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260809041638.2402705-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260809051820.2436530-1-irogers@google.com>
Subject: [PATCH v4 0/2] perf python TUI report and flamegraph
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, jolsa@kernel.org, laixintaoo@gmail.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Implement a perf TUI using the python textual module. Using the
textual framework means that in most modern terminals the mouse is
supported, the color scheme can be configured, and screenshots made.

The work is dependent on the extensions to the perf python module
merged into perf-tools-next such as commit 88439191ad5e ("perf python:
Add callchain support"). It is also dependent on the python textual
module for TUI support.

v4: Fix typo of profle to profile and tweak argparse command
    description to only mention flamegraph after that support is added
    (Sashiko). Sashiko notes a high severity issue because the script
    depends on perf Python module extensions that are already
    merged. This is because Sashiko is testing the changes against the
    perf-tools rather than perf-tools-next. Verified
    rich.errors.MarkupError don't occur for kernel DSOs, primarily as
    there is always a space after the square brackets.

v3: Tweaks to commit messages (Sashiko).
https://lore.kernel.org/linux-perf-users/20260809041638.2402705-1-irogers@google.com/

v2: Migrate from inbuilt perf python interpreter to perf python
    module. Improve the flamegraph performance. Use the textual's
    color scheme rather than red and white.
https://lore.kernel.org/linux-perf-users/20260808065743.2328212-1-irogers@google.com/

v1:
https://lore.kernel.org/linux-perf-users/20250725082425.20999-1-irogers@google.com/

Alice Rogers (2):
  perf python: New treport script
  perf python: treport add flamegraph support

 tools/perf/python/treport.py | 561 +++++++++++++++++++++++++++++++++++
 1 file changed, 561 insertions(+)
 create mode 100755 tools/perf/python/treport.py

-- 
2.55.0.654.g21b8a5bc05-goog

