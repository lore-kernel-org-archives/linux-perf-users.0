Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDB1432313
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187174; cv=none; b=Nu+NYfSuUJxd33XzON6z0CMWH6S6UtvbErD29BWjAqm7fnngbMpOrivArRrjyWKrC8Bqn7IYMk6djRXjkb/E5IaBnxr883S5lyq+gvqJpo+8+FDVPx2Shfej1pg9kOUL3mniNKKbi5nzDPyxkGJWHSwXU8arEmVYudbMcY4horM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187174; c=relaxed/simple;
	bh=uBWYryamCCGagdIxRdCXv97bZB5gatTqnWMxaGIh4rE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AhNe7BtfjhQRX2Q/QSuCNk6+H22cPIYMZ2nXuaFkoIICHaqjDnW3DUuMs1vnYsJwFhDoliE0J6FX+p5zIXgKcEK9gdqxfvWdI2BzbeCVaCzJRWYVFbSzthOGtAMJtGNdu+DpgWTZnQPyTKWnR6vUt342Osy8TXZ3ee9vtJ+xtDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SBbqcdMY; arc=none smtp.client-ip=74.125.82.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SBbqcdMY"
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-143803143c4so234209c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 11:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790187169; x=1790791969; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ej5EmIJDFJ49SmsVmXR0TuxIRzHOLi+vwf1azaL1f/E=;
        b=SBbqcdMYOG+80MrlpAmq53CDdypJTznWoOfxM76ngM8Lwafa3Rm2cQWfUdnjFaIP6A
         uqqfLYC0+eE2knVOpG5yy4SiBt1cxJzPjqj/yuCcJviXnKoWz8dLiX0l6cvpxhCr4Fbc
         cIHuyzutFsrXpwi7fX3OduXuiEZCLD0u2GxnCdfsNn47ri2XGKuuOMSIvR5P+EpZ9Yfu
         e2yjVHpleXwsUE14IkRN33N5s1WtSGqNLme66EJiJjNgrPjZnAv6AujzlpgS4/HOvp7P
         W8RvyXUm7a1cmzC5l0u2MUfLfySVScv3uCyuHPaGhCEu7ww02oh2S55wVEOad61/Jvs+
         ASlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790187169; x=1790791969;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ej5EmIJDFJ49SmsVmXR0TuxIRzHOLi+vwf1azaL1f/E=;
        b=StUYPrlyRYhQZ0nOtpwgUyHGfTUPT7LggnVCUmaat6igmSZwKPIbZYvYmUGxkcGLAe
         KHUJ3uv6TRRW1pSkaFPyO3czfmUqRh6H1hGyuv7Jdmilu+bJR02Z5I0F49jNkzej0IgT
         PJCiclMDAY5qmMdYUyN7PZJt1izb+CwnKC5Ox/5Off4rQPjhVh28VSgUGLSv6NWLfjZO
         Sk3VL5Xz5JGwJ5Wqi3E4oLCeM4gDOVJIgtGo/x3ZuJqGuGV3eN8Ncpv61+b7EjFAi0de
         R/AWK3hPaVuNIUaiI2HKJUshP8ZCgEF0wDBNl5fWR2XG613WghxJO1GDk0iUfCASDTwg
         JqZw==
X-Forwarded-Encrypted: i=1; AKwUvBzkxX8VVmmfNu88GzL8o377gO60kptT7Sv1zPw4l1dON2/ZiW9k0sQCPDTlil8BGdqLMzkhJaoYDi4k+yG+5Kfy@vger.kernel.org
X-Gm-Message-State: AFuF++mqbnCOc5IgzKxDeS/xSk42OqdPA1wQDMwG5istY0SK0UK7zJN6
	kOW25gfJlHfIKp6naezomrZEVGKFonp5beBaahL4xg2FTSFZWsffC6OL59AyMh42FqwhZ+EShDH
	1RHf0IdsOUQ==
X-Received: from dlzz29.prod.google.com ([2002:a05:7022:49d:b0:144:d6d2:5015])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:3a08:b0:144:f079:2700
 with SMTP id a92af1059eb24-144f916a57cmr4214489c88.35.1790187168853; Wed, 23
 Sep 2026 11:12:48 -0700 (PDT)
Date: Wed, 23 Sep 2026 11:11:27 -0700
In-Reply-To: <20260923181213.3032038-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com> <20260923181213.3032038-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260923181213.3032038-5-irogers@google.com>
Subject: [PATCH v3 04/49] perf python: Clean up pylint warnings in treport.py
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
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
2.56.0.rc1.310.g51773c2048-goog

