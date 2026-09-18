Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C1352CCE8
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 21:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789766427; cv=none; b=Sj2or8578xHVK0UVsTOJQGr58zOxbJkqne1OBeN6WtVr5DoiKKlz4fcTTLM/9TBj2HV2o1MFt+xnNa96lbsNPEbP/CtBvhnMYeZ7OepXT1eh8KBhR7FZxkZ8Qk0S3xRDqNvNR3+0qKHDHnQS1TfQbtRc8x2UV4kqujOLnqbkBMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789766427; c=relaxed/simple;
	bh=AoVCVBDnSH1tZsUSOAX8SBrL0Tds9gAMjAESj9HjNRU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VpSgXGngktKkxRfdmREVKGNKxsTYgDaCVEpad9VJvlrHqCVr6RgIHpr9IfBwZsAIrHIMw/kwVjg3KYGTzGLlSYuqnkRTnpw2jlN+mccvd02yEnrkbUk04Y4fWBAch43gMZL12p8KgyGvXWAGGuJOtNY6boPZ/unptaEBXOIAGdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eE0ilMMJ; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eE0ilMMJ"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e54b6556aso1629359a91.2
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 14:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789766426; x=1790371226; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CjdQcI57qkny14hvcDqUMxxP8hpzBsCr23TXxvKZDyo=;
        b=eE0ilMMJVMiGWt701exW0BaNsq8RTgIWxDfKeqiiNL9kuzWnyNloVE5/pkEVXFonrg
         uQCFQvQNJE0+GIpsZr/eOJox7fmfD/cf01Wno5zwAPfWBbaIWNzLPBaOWctJN4IbRdNr
         B6iV2lFA2PXhtkyVwIPnLUbTa67gzR7v4Czp+zMO5fORWU9jRkr3wLquI7ten/SdpxgZ
         0GdCXOtuwSMwsr8a/Qz6w8AqnWXLLvFpERSV8q9Dyzh4QZ0zmEyjB8y9bQuHYcVADUHC
         Pcm0FppBLr5pBajVkSDnLudmQ2R4Uk+LqhFMfN3F2QBmyfM/JBh0XP5xpZSiMJRkyXVW
         B4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789766426; x=1790371226;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CjdQcI57qkny14hvcDqUMxxP8hpzBsCr23TXxvKZDyo=;
        b=B19KbK4uPoB24flc5wi5Y3JLqCgR54wyHzjzxp3TDeD20Je/dT7ZU8/EOYuZL2R1XI
         h5NCH9cCrCOiTaRFPfuXR64VTZlzAjBVlh4LLW1HIigh7qDKbGiKjtkg0WkbEISwLJq2
         YeQqdstXYe5yXsLicrTvVVAMeGgquXE9yzlU4YfUjd6KrmPzl6DReYx5+wa9FSvJmMtx
         4VqRfHcva5yTT377I31zdejmIG2iEhdL4K+27LNPFm5kcUj3kngxiikzK1fbLTS3m9Ep
         Yn9Cj9d/1fGf5raS8ITvFWOzhYso7a/GkekCnHszO7azjEHAFGZcWMdcEAixbrO0trAg
         lhUg==
X-Forwarded-Encrypted: i=1; AKwUvBx4J2so9pCEXafAAKwQdWoIdabnnwofE1+WHkClEJqYkmMM/xg+x56F9OORGtVIhQ8zNogsBpkqcr5n54SU+3kq@vger.kernel.org
X-Gm-Message-State: AFuF++kCiWcGjK7XJCl+lJI5RE9+byYz2QVjbM/wagDt+BFUzk2qMaNh
	7k5S7raYLLSlEy0oVERTVH487NaEwPMRDr78J/6LLfgxzQeE38rJEwUbe+u+0ASd5Po+5Em7KMJ
	XouBVMK473w==
X-Received: from dlbrj1.prod.google.com ([2002:a05:7022:f401:b0:143:9658:f913])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2243:b0:398:c3c9:d0ae
 with SMTP id 98e67ed59e1d1-39e549bb69cmr7314005a91.0.1789766425636; Fri, 18
 Sep 2026 14:20:25 -0700 (PDT)
Date: Fri, 18 Sep 2026 14:19:29 -0700
In-Reply-To: <20260918211932.2966061-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918140659.2501976-1-irogers@google.com> <20260918211932.2966061-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918211932.2966061-16-irogers@google.com>
Subject: [PATCH v4 15/18] perf test trace_summary: Improve error diagnostics
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	Howard Chu <howardchu95@gmail.com>
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

When pattern matching fails in test_perf_trace(), print the command
that failed along with the actual match count, the matching lines
found, and the last 20 lines of output to aid debugging.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/trace_summary.sh | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/trace_summary.sh b/tools/perf/tests/shell/trace_summary.sh
index b80dea77cec6..4589b4581419 100755
--- a/tools/perf/tests/shell/trace_summary.sh
+++ b/tools/perf/tests/shell/trace_summary.sh
@@ -28,10 +28,16 @@ test_perf_trace() {
 
     count=$(grep -E -c -m 3 "${search}" ${OUTPUT})
     if [ "${count}" != "3" ]; then
-	echo "Error: cannot find enough pattern ${search} in the output"
-	cat ${OUTPUT}
-	rm -f ${OUTPUT}
-	exit 1
+        echo "Error: cannot find enough pattern ${search} (count=${count}) in output of:"
+        echo "Error:   perf trace ${args} -- ${workload}"
+        echo "Error: matched lines:"
+        grep -E "${search}" ${OUTPUT} || echo "none"
+        echo "Error: last 20 lines of output:"
+        # The summary is printed after any trace output, so show the end of
+        # the file: with -S the head of it is the trace, not what is matched.
+        tail -n 20 ${OUTPUT}
+        rm -f ${OUTPUT}
+        exit 1
     fi
 }
 
-- 
2.55.0.1082.g2b9226bbc0-goog

