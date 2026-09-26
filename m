Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C712E762C
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790403663; cv=none; b=QIYcAZkMuRAWqE4K/dmMSxID2o2CGaLQNgw+cFoJqQt2A43z0dqxvnbQ3h6xzGkSfmU2/rK27if326Ns6A3kVM8BsqUZNu8dy3Quy4K9bc71f+f2CKENv+wqtxekHvLDVWxjDsuYvROOpk1ZriL84OEUbU2SCM1y8j9Ook/WFDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790403663; c=relaxed/simple;
	bh=6QRVP4zAK4B4cSVT8i51HX3UZXbjJyoFhltLRp1HpEg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nzwWB65uRd98t5y4RWr96ex1UkMzLZplfrWVUc2gwHNhfEMFNR3EuyQ9t8JBsW1MMNLqn5IiKesfSGar2o3s7TSnxVhZr86627uNOadGTtRWkj7FyoqednkhRdBJ+5KgsiatG56v4TA2Djg8zOzoPpxM36G8Yu7+CpsCAJMHNTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kJR11QT9; arc=none smtp.client-ip=74.125.82.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kJR11QT9"
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-14383177746so2196980c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 23:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790403659; x=1791008459; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JHXL78ga59h44oaBMzuM9zcc4XanZGNc4b4JuLKXFd0=;
        b=kJR11QT9gAWHzZ1eKkvGszUMSg88Vv7oN1zpGkEhRfFCAa425lWArJa3GLLac1VYRl
         1yAPuzANHicLqe8WuKOhmoMDxRteSZVY1GX6WAbcK88Mn1PYhZpA1Inb078iQ0AurInR
         wZ5q0YfnLqlv1zraA6RexP5+I9/i9oHmfANmUPe1uBGQ6c8CQRc2DKpdGng8600DXpp+
         N4tbrWkGefuXNDWEw5Ap7jaZU5ANJO03O+4MjK8cADe1HdK+29cf+nRdwlHIJ5af0+mD
         tssKO919l673NqlhQpAUIYFW+vNuVTz/TWA/JTBzK+xf/CaylG0488kQy5TYEfAplefU
         BkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790403659; x=1791008459;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JHXL78ga59h44oaBMzuM9zcc4XanZGNc4b4JuLKXFd0=;
        b=lgn3ralCNBbYtoaj8GC+4cORz5CBFNmKlk6qLbCnzEapFQTkVoVareoNWZwJrJ2LVr
         6htOMHS5co9JBAxJ62TF2++4aR0r1Ql7Bm0X+IdKh2xWq3Yc3t96mfVwAGtKP+ngFGJW
         S8q1BngIxjPhisBDcxLPPiigNCsPJq3K+5NiNRercJjdC7pdhgIQ8eGFC/nbphcxhJzT
         xTjSHBPbAtdCaeURX2o9BEkH6kirWV3WmbZXIf5PcvqgCq3ikloK3JdK6/dVP4VJPEZk
         DU5kGYGG64l08OqqPctQU6zpmaby0VRikm65g++yA+NfnyiK+1/6PJcplXRmoNoNIFGr
         Nrow==
X-Forwarded-Encrypted: i=1; AKwUvBxWYL4i96ypqdJhkPzVylgztgTZHrbuZ9Oq3+E+yl/Tt599phIuWbGGlxZGaUYuS4AVVX6l/FcL+bEE9kgaSsiL@vger.kernel.org
X-Gm-Message-State: AFuF++mCby2Zk5gLvsIXhmV9jTBNEsicdnWpgxnSoCnF7sHqjco4NjDh
	cyCXQ6fl1hJpPIdQ/+tMocSUJGCHvr6PrI6BTU4xIkPz2GE2IRKie7qhmp3TO9r4bfVPwBmntQC
	LO7do4N+WQg==
X-Received: from dlbpu5.prod.google.com ([2002:a05:7022:e885:b0:144:c6ad:5b30])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:298:b0:144:eb46:c40
 with SMTP id a92af1059eb24-146cddbd24amr1910770c88.9.1790403659144; Fri, 25
 Sep 2026 23:20:59 -0700 (PDT)
Date: Fri, 25 Sep 2026 23:19:31 -0700
In-Reply-To: <20260926062029.800743-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923181213.3032038-1-irogers@google.com> <20260926062029.800743-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260926062029.800743-5-irogers@google.com>
Subject: [PATCH v4 04/49] perf python: Clean up pylint warnings in treport.py
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
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
- Clear session = None in a finally block after session.process_events()
  to break the C perf_session reference cycle before launching the TUI.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/treport.py | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/perf/python/treport.py b/tools/perf/python/treport.py
index 786b852f471c..0921b428b1aa 100755
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
@@ -549,12 +549,15 @@ if __name__ == "__main__":
     profile = ProfileBuilder()
     try:
         session = perf.session(perf.data(input_file), sample=profile.process_event)
-    except Exception as e:
+    except (OSError, ValueError, RuntimeError) as e:
         print(f"Error opening session: {e}", file=sys.stderr)
         sys.exit(1)
 
     # profile.process_event is called for each perf event to build the profile.
-    session.process_events()
+    try:
+        session.process_events()
+    finally:
+        session = None
 
     # Visualize data.
     app = ReportApp(profile.root)
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

