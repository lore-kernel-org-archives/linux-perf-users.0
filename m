Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA75457E63
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187173; cv=none; b=SEwWCkG3sEndgMJ7qRGZopc2m6eD/iVSXjmKtrYeSPp3KVTockTGlzNPzOunR3d02qpanmWSVbhsTWVWneb8OIJlVqVmlEgu0K3dyVmb28BhEwk7zKoMRmfjQ0qU7LzNemBU/UHNOouUyVtfjmGegWQYB5RjEgxbYmqwo1mk8HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187173; c=relaxed/simple;
	bh=GBXnpOpEL4Afytgv6uvsYP223Sk/xeTE71TgVCLUw7Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s7m9CWfHJ1e6uuzMtxJ+qvub2MiMSqZU2SbS2p0fqIMPZlbAZxijdU8sSXYfqrfy0DfdGNCVy6ekO/OlRKgALSQoeSJCdkoHns8n+9HMC4Lh3e/b/TS0EI+dZRKBDVV6B3lT0cXBIDeneWFqOA4q4D+fVHx8j/JGGdrl98tQdmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cx8SrFRv; arc=none smtp.client-ip=74.125.82.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cx8SrFRv"
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-14373747468so1807168c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 11:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790187167; x=1790791967; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qd+spX1Ew/OcQ1XbO8x1Q0IsSd9yhHXDUFC2iI+k0nY=;
        b=cx8SrFRv0HVyJaI1KMQJFO6oG85MLj9Zc7qHgIqSogMzEfx/kGbAvKBxnvhS6vvd8X
         n7upZ+kKcsJOJPc0uDAuMXeGRJFu/BLkpWcN4D/CuL3L9O1u4VKqAOKLjlLqDrch++VE
         VfZag5kdzqevV5069qkPW532kSXDky/z68OZeeikUAu0W1bD+R29tQ9+znU+wtmsVrLk
         5v9fxCka+Zi7WwCARcCiruBHD/aLnHoQ7mDC7PuzNRk4xs4IqY2j6i7NQMUWE4XJnK3a
         SEkjkIV6mDrofm2m7XkR1p/c6XvLVuYTy9HCf31HexvNamwvtoUh9rsp2HW87YhEGAPa
         abwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790187167; x=1790791967;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qd+spX1Ew/OcQ1XbO8x1Q0IsSd9yhHXDUFC2iI+k0nY=;
        b=FiwlAFqQEwQ9IvxciQlgPFNNtL6kMFHHmHhFj6aN9B6G1B37kixzgznJIr0JZP0DZK
         YPhYWB7kcUxxzDctCEDFHEaRQ2zXUJMuITAFrfNR57wPGeeRxfFDMPtd5biUtlAlcFeV
         9CiAKV2qWFj2N0+13bPEl974WNWRrwhSjZtC3NZCixBhEDKutgE7Y95bYTGvz41JzyNN
         W5GUUeXXekprj8MGRrn3i5RTmMVWHqtez8etD34VAEwOx1E8jDn1xDjU0lwA6tlak6vO
         Paow3MkywtKHvXUnQ+eD+nimOKVwFENUfgbzqb213cGaV1N2tcoUBoSx4eLgZponc/Yo
         T4pg==
X-Forwarded-Encrypted: i=1; AKwUvBz4/hr/snH08MZDY801h8Pm3bMkco+VPeDWHpzHqoUKHekePLFZfInL4M/xznLVFsCkumqgG7M418KTZgYFulOU@vger.kernel.org
X-Gm-Message-State: AFuF++nBKD2tmDWBQvJeI4CrYLDIyCgnkpM+xx2LN7jNaShzSw8c9WED
	BBoY7+CQQMfx9BxGuysAIgjdIX/OkBGghIgHvm/fYlbyYf+W2gDIUBPVBbP0VTirb0fMda16eSN
	LCvGNJMsR+w==
X-Received: from dlbvv19.prod.google.com ([2002:a05:7022:5f13:b0:143:6e9d:bb50])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:380a:b0:13d:31c5:815e
 with SMTP id a92af1059eb24-144f9158cadmr3192420c88.17.1790187166925; Wed, 23
 Sep 2026 11:12:46 -0700 (PDT)
Date: Wed, 23 Sep 2026 11:11:26 -0700
In-Reply-To: <20260923181213.3032038-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com> <20260923181213.3032038-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260923181213.3032038-4-irogers@google.com>
Subject: [PATCH v3 03/49] perf python: Clean up pylint warnings in ilist.py
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Replace bare 'except:' clauses (pylint W0702: bare-except) in ilist.py
with specific exception tuples (OSError, ValueError, RuntimeError,
TypeError, KeyError) and use a safe '.get("name", "")' sort key in
IListApp.compose() so that ilist.py passes pylint without warning
suppression comments and handles unnamed PMU events gracefully.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/ilist.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/python/ilist.py b/tools/perf/python/ilist.py
index ebff0a843b7a..86bd65452e6e 100755
--- a/tools/perf/python/ilist.py
+++ b/tools/perf/python/ilist.py
@@ -82,7 +82,7 @@ class Metric(TreeValue):
         try:
             val = evlist.compute_metric(self.metric_name, cpu, thread)
             return 0 if math.isnan(val) else val
-        except:
+        except (OSError, ValueError, RuntimeError, TypeError):
             # Be tolerant of failures to compute metrics on particular CPUs/threads.
             return 0
 
@@ -419,7 +419,7 @@ class IListApp(App):
             if self.evlist:
                 self.evlist.open()
                 self.evlist.enable()
-        except:
+        except (OSError, ValueError, RuntimeError):
             self.evlist = None
 
         if not self.evlist:
@@ -450,7 +450,7 @@ class IListApp(App):
                 pmu_name = pmu.name().lower()
                 pmu_node = pmus.add(pmu_name)
                 try:
-                    for event in sorted(pmu.events(), key=lambda x: x["name"]):
+                    for event in sorted(pmu.events(), key=lambda x: x.get("name", "")):
                         if "deprecated" in event:
                             continue
                         if "name" in event:
@@ -460,7 +460,7 @@ class IListApp(App):
                                                   data=PmuEvent(pmu_name, e))
                             else:
                                 pmu_node.add_leaf(e, data=PmuEvent(pmu_name, e))
-                except:
+                except (OSError, ValueError, RuntimeError, KeyError, TypeError):
                     # Reading events may fail with EPERM, ignore.
                     pass
             metrics = tree.root.add("Metrics")
-- 
2.56.0.rc1.310.g51773c2048-goog

