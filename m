Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22623806B4
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790403660; cv=none; b=vFhPyuVEmO5IKuHRc89Kqc0GwMmQGVtJDPo1TztyegPNFMBQne8nn5LR7qNK2lDjGZygXMWPs+jGCgW1TIZmhEHB5NPkjnv2zAH2UZS5rSQ/jL23wAoHIRhimpARuQ3UX4+FExLDK565ddAK46H9fkD49teVNZs9orWU1YB4u3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790403660; c=relaxed/simple;
	bh=vPJuwqmHNP2NGZ10JplJioeiw9yXQBy5D+/zqZ/c66Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OKMKcipIzmtrB6dPLW2PcIpGAT+SItLoqLDm1IIcwhkt4Xat+RrZP+PoIXns5cO5SKZh/4dHH84KqtVX7cvnsRGnuQFxkk1LoypaZsx8KqEoWdf9bhuL+dN+2fRN0mjWheTE5aGX8b9sRconQFXjRz8OybvXhmiXToMs/RCQDUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KuJ2YlKq; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KuJ2YlKq"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30f1b904861so2453607eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 23:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790403658; x=1791008458; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qg783eiu3NoBdfQYfxVtHRcyW/BPYIkmS2YrKghjzk0=;
        b=KuJ2YlKqbfnkpAhmy5Z305icORa3+iL7mO2IB1qLWEK4YlFfAFSIe6uboxSF3/BVE8
         EQdak5aXjfAcs/gM2zljTwFpkYQp+bmFMUq0zVWIae5DV0zA9+IyY2Z16Sk0ghBZCq3L
         fZxmuTjnrd/42Jwh4fV5l8zRY2c2J3tqLs+YE4DERBZt251ChP1AacmB+LS+c/VMRmz4
         NG02RDI2JhUEqK1TtrCWnhdy1wAipX/4JCB8Y5cLGzXjtnzap8VrLUrpInK1u3ThtV+1
         u4ZLYSe//J/Qj8pWwKNfUN5bQE6fXBnc+lpRwQ6LL9F/zWJt5d9mb+x93xAUz6UfQObo
         8tTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790403658; x=1791008458;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qg783eiu3NoBdfQYfxVtHRcyW/BPYIkmS2YrKghjzk0=;
        b=IcY0BkuBS7G625okgKkV37zgQEJJTZ2/jQ1GeOW5PrHebgkj+yrKVv0YbnA1NRo/XU
         DmHUvIcTs0kHo34FiC32qRjQ5Qsdq3eH+dmdEYBFpEWSCH2Wy5kQ8pTLkQVItmj+A3FK
         aodp9F7zGnpXP3Qt+Hp9jjzKqUN80lbGLEZJIagnJjh68Rn5wyUCTXpRzOnAdegARL4a
         6zUwRk/85Z8KK478b0sj/ifB9ykRLJcp94WI8cLnbiQTiEUx1B+yz9a2T4oPVOJPydRs
         oNgtU7aBQXhoObEh/xRLIwBVhFbD/mIMYRq1Xd/+EMmbOVWl6/ubu1PCybUhFeJS+Nb8
         XlXg==
X-Forwarded-Encrypted: i=1; AKwUvBxg3apAaspw/S6swR/y5NdqGDOKaGu8+iCp6nFcprrROaW7EbvBy3pY+yXFaXhCXwBFdZ8hfF5xB9nTXqE/WAyW@vger.kernel.org
X-Gm-Message-State: AFuF++mlECsYF14SfXeeZprloHXx7TkfzmlWUMmEVIizabnyggmOr+Yu
	JPT1Pt+UPYDiEOtKxTm4UaQ/XtS2B5AntSC2AVyZpRwPz6nbhX0nAJXDy46SlBPl20w0VgIhY43
	Py9tfYq3u+w==
X-Received: from dlbro4.prod.google.com ([2002:a05:7022:1584:b0:144:ece5:c0c4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:42cd:10b0:143:6525:f9f6
 with SMTP id a92af1059eb24-146ce58aa94mr2120426c88.13.1790403657419; Fri, 25
 Sep 2026 23:20:57 -0700 (PDT)
Date: Fri, 25 Sep 2026 23:19:30 -0700
In-Reply-To: <20260926062029.800743-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923181213.3032038-1-irogers@google.com> <20260926062029.800743-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260926062029.800743-4-irogers@google.com>
Subject: [PATCH v4 03/49] perf python: Clean up pylint warnings in ilist.py
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
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
2.56.0.rc1.315.gc6ed9934b7-goog

