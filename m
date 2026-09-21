Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9A9358368
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789967249; cv=none; b=lNtV/9XNdbzxGWU2DE8UOqxd7fdGld/1I0j6wOy5FmIpspvpeNnQyWHTvp6YuM2upWXrmjR6mh1m01H2icjRDyGPgDitkj9JjZkYQs5yZA2Ljz64OLXWdQ+5a4NhcDcQDx1db23l53vei6EA99RzVTYbmPmpp4eF3aM0I6/qn+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789967249; c=relaxed/simple;
	bh=Qw4ZWkFWJPRmZ5O2wvrL8xQ8BuWvK+mBZlcas52Oe64=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IKLZtXKsnPAocjuYhR9uwKQq72boC8RhAjsvhxXYrWF1qkKkX8nw54p+QAVZ+QFJqHbM0P/WDfXHhRuLP5SWgRZxwGbkG4NVrdmh6ixP9FEWmd2E8GZt1mg2t4i/Ptum6Px8zX87xNIMXW7a2KBv+1yt3EuXu0293gSP2K3Jq9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ArW5a8IE; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ArW5a8IE"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39de4a68f7cso4760600a91.1
        for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 22:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789967248; x=1790572048; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wHMamU+PAKgDS7CB8H6YoOm/eLHF8p5TEtQXCGtGAPs=;
        b=ArW5a8IEyazflP1EL4eg9+F+6/Fm5fKB5Y6ZdDBJAjyuc2bMdgfcQCteC5kQqI5r0R
         fhQhYfx0Wz7Eum5OVmjR7ocWG12GjZ++LbmcsMEYXyLKL/OYfrz3+xeWYEYtJpg4wSLM
         01CDAyv6xXjuzJsYc/rzJkPIRx44gc1s2M7zjZqLx54uG4OhL/g17w2na/fccx12QGMP
         h39yGv2vw373ne8HIntQqJpYYROKvZiuKipCuoZFcI0x0wl2M/I47zl+NztkwfeX1zwQ
         mnWX7EogmY0BL6eRpOpy9LWpPuiEvGsNs6wg5B2ZlKyThaTWGR8ePJ5Do+A3M8TUZUtd
         sdzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789967248; x=1790572048;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wHMamU+PAKgDS7CB8H6YoOm/eLHF8p5TEtQXCGtGAPs=;
        b=Xsna7RYUGY9qlDrPncwBZDe5xr+BdpjgYEvQbXrDjtyZhicOLimj1DvrJ5Z1Tr+X6/
         7GF8099L3tH9rnxaaT+kr5Mz9lMjxRfu83vitFeXpjYW+70EQS4Ptzz3i4UZsWHYrOcu
         c/66CThFoXf1RvrWmKFCfVOLdKrZ1eWwwupX0b0JXwFB31T1bRmcb/tdTGLCz67Mjd61
         Xt8Y0S82lyxOcTWIMLlGz8t4F3/lwrNbxVxmoqag/52iRT5vUWUMPj20f0V4KoF+pZYf
         qp4Ofd9Kc5w+5FGi4LCl1LPG5PH0iZ8UgpY6wEfWZg76AVI00CXRd1BfdnWYDRoJRfcw
         yFeA==
X-Forwarded-Encrypted: i=1; AKwUvBxGRqWlV8iNn69+SLqJpADpfRUrRDk/GGxfpv8om715h3hsflFxvgXhm7LzQukKI60XAkBtQEfi60kzNyN8436y@vger.kernel.org
X-Gm-Message-State: AFuF++nu3rvHjRiw2I9+z+O6pEwsEnyMuw4vcIjEUKBHQKDR1JHPQYJn
	xflknsxA9qTqudo3posZRBZgjtVGsOxIc4eluHEtF2+o6SqJ0tnyjw2ZBeHKKDrOZHYDmsaxiuY
	xix6DbkKOZA==
X-Received: from dlak8.prod.google.com ([2002:a05:701b:2908:b0:144:cfcb:6cb5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c03:b0:3a0:4384:ada7
 with SMTP id 98e67ed59e1d1-3a04393f338mr2788149a91.0.1789967247535; Sun, 20
 Sep 2026 22:07:27 -0700 (PDT)
Date: Sun, 20 Sep 2026 22:06:22 -0700
In-Reply-To: <cover.1789966896.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <2b4c064f5416148998951cf2cfa95867d8f4ae0f.1789966896.git.irogers@google.com>
Subject: [PATCH v2 04/49] perf python: Clean up pylint warnings in treport.py
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Clean up pylint warnings in treport.py so that it passes pylint without
warning suppression comments:
- Replace broad 'except Exception:' clauses (W0718:
  broad-exception-caught) with specific exception tuples.
- Pass both pid and sample_tid to session.find_thread() so guest and
  process threads are resolved accurately.
- Rename parameter 'args' to 'pos_args' in FlameGraph.__init__() to
  avoid shadowing the outer scope variable 'args' (W0621:
  redefined-outer-name).

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/treport.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/python/treport.py b/tools/perf/python/treport.py
index 786b852f471c..082f5ca4a7da 100755
--- a/tools/perf/python/treport.py
+++ b/tools/perf/python/treport.py
@@ -91,9 +91,9 @@ class ProfileNode:
         pid = sample.sample_pid
         try:
             assert session
-            thread = session.find_thread(sample.sample_tid)
+            thread = session.find_thread(pid, sample.sample_tid)
             comm = (thread.comm() if thread else None) or f"unknown ({pid})"
-        except Exception:
+        except (OSError, ValueError, KeyError, RuntimeError, TypeError, AttributeError):
             comm = f"unknown ({pid})"
 
         period = sample.sample_period
@@ -412,9 +412,9 @@ class FlameGraph(ScrollView):
     }
     """
 
-    def __init__(self, root: ProfileNode, *args, **kwargs):
+    def __init__(self, root: ProfileNode, *pos_args, **kwargs):
         """Initialize the FlameGraph widget."""
-        super().__init__(*args, **kwargs)
+        super().__init__(*pos_args, **kwargs)
         self.root = root
         self.cursor = root
         self.selected = root
@@ -549,7 +549,7 @@ if __name__ == "__main__":
     profile = ProfileBuilder()
     try:
         session = perf.session(perf.data(input_file), sample=profile.process_event)
-    except Exception as e:
+    except (OSError, ValueError, RuntimeError) as e:
         print(f"Error opening session: {e}", file=sys.stderr)
         sys.exit(1)
 
-- 
2.55.0.1082.g2b9226bbc0-goog

