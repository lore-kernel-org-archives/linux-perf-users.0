Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268703515E8
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789967251; cv=none; b=l1bBzmNb3ec4ZLCUqaGlCtoRAkjU2JuUl+USmIxijzgN47xiUZpINE0aAiE5DMrVA8+ylGPJfKcXyzCL7XfM0QsefC/vQDDHdLG14Hj2KQfSRpWs1zJQ+ar2SliJfHLkhajPieCWBrzKJWhnFDqwMcdIQHfIfYuTXvuHkU1QgX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789967251; c=relaxed/simple;
	bh=9CG5+TIVVVhdILbf2bNJOX9PamwB0I16qey/intpr9s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kd11nYgk2TQjoBPe8tQPzRnzXC7eicXPWZ2CULVwPCFbK0J97/A2DweYY9Z8b6VR5WvbVj2mRSYxDJVj4qB+WQ8QFXydz1rJLckaPfsajLjeHbHR0RKiJayvGbCsImgEnjRDNB75sKT83oA2xGGJlpOUhjdoArdyrCDXry1v9+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xp+ehLiw; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xp+ehLiw"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc489e7a701so3948255a12.2
        for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 22:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789967249; x=1790572049; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SXQ1t7M/ttKG1gpCPiapMoUFSHKPI4WUjvFCcDFwkq8=;
        b=Xp+ehLiwzScPa8GKyn6kVsZc6Lijw4hb5PioDrVaspph1rcew0/5VMdEHPa/VWnZkQ
         tydcRWxZROAAwOHLra0nckFKpsQ252EtIGCdTSBb8184YoNt3Cq8PetaSDH4MsKyMD0v
         5qaZuSFSGtVpWGmHQB04+wOu8SvLlvYa1csyLsTAsnAqGgSWJWJXZyAZX+L79Y+0AQzi
         zK/QyiioeCOTMeu7TKTMaBaRNAi6vMZaf6rdixb+NC0csmr4Xxztwfuc5BBv/BAm8AuX
         Gzkts++mAmlPeGyyjV+ncJs2iWpqbKuNU+01Ax0NdKnezFStvkkk+XUQyn3koCGOBFmY
         nOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789967249; x=1790572049;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SXQ1t7M/ttKG1gpCPiapMoUFSHKPI4WUjvFCcDFwkq8=;
        b=Iu4ItFoE94HYrbp+eLnpnLFifP6RwKOithd1Z4Tx6/JCmUtrwivHbCFRKnesJzvnxi
         hb5WPde/9aDUCVDui6hhlWZl5cz5Qqw2TG1IZG5bBO60fAHQL77xJbLm8Hwrc5EruShS
         my/ErTL7MLeisamFhFd6I8Iaz+xe0ihHOkTd4TJg3+qrKg11jsoOuhpntjsp5OSFcPXb
         Gta6LbVD+ET+QAlPuMD+vZlA9zI0rLabI9ExHuz2aZ/MFfbJ2QOcyEZTrTonFL2wQDRH
         h1o/l+6ARh6Gzeba76B69u+Kp0x6e6vgsJF4tMhN2hK8IpE/GbwMn5MX/IHdqkV4mCyp
         DoIg==
X-Forwarded-Encrypted: i=1; AKwUvBxZIZWXDIfZLNau/Ex4TtCmzcm4YG2koKCO5JmSTdNhi4IsOfqIb0UkoA8zmKiCt+svLeeAeJQIJi0o10pyF+94@vger.kernel.org
X-Gm-Message-State: AFuF++lK+WPV4+kn+mWpvWjWESXyAB+MoGnlaDu5v2HshIUykUwboRCs
	mpe39RQtPWGsjXTXgrnXVwNvfOK7SFoKxcsLIyqv+FoyuPeHi+BUbVIQJxHlp7KeQklBI8xgpIa
	vfwcCxjfd4Q==
X-Received: from dlbou20.prod.google.com ([2002:a05:7022:1114:b0:144:d82d:aebb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:a08:b0:3dd:a006:5598
 with SMTP id adf61e73a8af0-3dda00655e9mr8559353637.38.1789967249392; Sun, 20
 Sep 2026 22:07:29 -0700 (PDT)
Date: Sun, 20 Sep 2026 22:06:23 -0700
In-Reply-To: <cover.1789966896.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <503b656ff0cef2a2d6126b74e7cb4f3c2c7f823f.1789966896.git.irogers@google.com>
Subject: [PATCH v2 05/49] perf python: Clean up pylint warnings in tracepoint.py
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Clean up pylint warnings in tracepoint.py so that it passes pylint
without warning suppression comments:
- Catch ImportError instead of bare 'except:' (W0702: bare-except) when
  importing setproctitle.
- Remove unnecessary trailing semicolon (W0301: unnecessary-semicolon)
  after evlist.enable().

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/tracepoint.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/python/tracepoint.py b/tools/perf/python/tracepoint.py
index 15b0c8268996..9d49a25b3b1e 100755
--- a/tools/perf/python/tracepoint.py
+++ b/tools/perf/python/tracepoint.py
@@ -9,7 +9,7 @@ def change_proctitle():
     try:
         import setproctitle
         setproctitle.setproctitle("tracepoint.py")
-    except:
+    except ImportError:
         print("Install the setproctitle python package to help with top and friends")
 
 def main():
@@ -29,7 +29,7 @@ def main():
 
     evlist.open()
     evlist.mmap()
-    evlist.enable();
+    evlist.enable()
 
     while True:
         evlist.poll(timeout = -1)
-- 
2.55.0.1082.g2b9226bbc0-goog

