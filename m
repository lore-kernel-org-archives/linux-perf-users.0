Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C3C382F1F
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 04:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784176384; cv=none; b=Wbi3FDx4T/dpUw1KHLaFUSzd68mBTr3bNThMPlF+Y8qTKhJJpto7FBYht6rDFhgyOpCI/AU9GIhOeikKYqh7W6trmJTaC7O50ZIPEiaGnBNbJbQATGgENQz/FAwAuPzu60mzrDmUy9p5y99eXiYIjA6oJrn7nJHzWf6dLeB4I5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784176384; c=relaxed/simple;
	bh=VC5bd3wbqVARSSYlOBQAUgo/LsveZVzmlW7GBDDKkFU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Iz/pfgWpdVLSGXLMBRN1ZskUOyNDh3NXdaDisNzXqL9YVtLa9NzEyJtAAbiFkW+I5sea2gzvEDXhBB+ECLFkNxW8F2uy4qPOoK/9rWa1mGJtY1mbCPxI+q0rRZB3QKVehpQGQqSAzIOmlO15dOfZ6q16wJ36m8N5Fu5kXwPvkt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jkif7qZZ; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jkif7qZZ"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8895156101so6611431a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 21:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784176382; x=1784781182; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h1E2KgxI86OBAZTp6hMwxuGK9/mjtCxRoV2z2R0u4iU=;
        b=Jkif7qZZ9EZrZw+xSObLreFSc4JFBJAgSvadcbKBy87L1wnPUDEI5aRhrNL3LABdWg
         PCgXYWD6yTGVfw7D4aHLrFuctrAo56SgC3ALvnhVjaH8IoGd2SvroUdKyfpQbdpjCUM1
         5nfAtqh7KqDFA8rKOebabK8E/HK1snT3WW8TkpNyNM/kik+ArriLJV29FljsnyXNyM1F
         sp5NH2JQhmeL9OJCvj5BPJMsPgl3rZWX3g78C3TuJei+OQP3w4ngP6Jzc8JLic+OePXw
         jQvbUX10PTHXfoty4ZK0leCh62WR28u3zKGkVSTj1FEwRAueMjjuxtek/Hav3HEyDfIy
         ze4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784176382; x=1784781182;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h1E2KgxI86OBAZTp6hMwxuGK9/mjtCxRoV2z2R0u4iU=;
        b=gnbTdZIUzEfj6/2qxxvA+81aQP2ySSCSvtM3kaBgDvNDhvR+Ouew3h2FKGLvRB0yU/
         s0enfRKdyvFHHmSCEp2InTcdU67j40TpA8tV/HZztNzlhhokNrh4sVl3iNRSXUT6rCfW
         JNkhKpIa6EesxGQF2vK7oMhHcAF/S8IYKDnGHOFjjlla6Nr7WuSqgj3/qdo6QQkPWTHa
         uSCWPoYS7D42bRBZIWRN4ytOVnIMKiBHYyf2s8SGHa0hq52YAZpDo+yaijlWz8UXYLPx
         pvSji0IvXDXgrm8ZydtmzVrfVw2z/aWk5YE34i/MUo9glYNTZ9vOAKXf1Nd0dqyI+Iu2
         awxA==
X-Forwarded-Encrypted: i=1; AHgh+RoGh5A+kGf7nmGbzNici6fYbN8A/DH8BtGvotSNHefjLGb5ihdFLR8uJbEgOzjGkEs2/ZXSK8OIUe6rPA1fEJ6Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yza2j17hKkAB9Bfz4OPBZ8E1DGo2sES1/+Dc5z2pSqDIy8BTRFR
	dcnmkJaGyLm5IB6Bq9Fx/IS2SrHJ9b+drwt6dFuSz78feEbfX8jRK0VgPygnR2GVEFMJnhPdUNL
	J+Pj4AvxEZA==
X-Received: from dyau17.prod.google.com ([2002:a05:7300:6011:b0:311:99c6:bab7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6d9b:b0:3b4:71a9:cd8f
 with SMTP id adf61e73a8af0-3c36c365548mr6280952637.41.1784176382072; Wed, 15
 Jul 2026 21:33:02 -0700 (PDT)
Date: Wed, 15 Jul 2026 21:32:12 -0700
In-Reply-To: <20260716043223.388233-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260525231900.3527228-1-irogers@google.com> <20260716043223.388233-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260716043223.388233-4-irogers@google.com>
Subject: [PATCH v3 03/14] perf stat: Extend STD output linter to test basic
 New API checks
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	ctshao@google.com
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

This patch extends the standard console (STD) output linter script
tools/perf/tests/shell/stat+std_output.sh to run the basic no-argument
check a second time using the --new print flag:

  perf_cmd="--new -o ${stat_output}"
  check_no_args "STD (New API)" "$perf_cmd"

This ensures that standard console outputs produced by the decoupled
printing callbacks are formally validated by the test suite.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.5-flash

Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/tests/shell/stat+std_output.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests/shell/stat+std_output.sh
index 9c4b92ecf448..233e0a50eb33 100755
--- a/tools/perf/tests/shell/stat+std_output.sh
+++ b/tools/perf/tests/shell/stat+std_output.sh
@@ -118,5 +118,9 @@ then
 else
 	echo "[Skip] Skipping tests for system_wide_no_aggr, per_core, per_die and per_socket since socket id exposed via topology is invalid"
 fi
+# New API basic checks
+perf_cmd="--new -o ${stat_output}"
+check_no_args "STD (New API)" "$perf_cmd"
+
 cleanup
 exit 0
-- 
2.55.0.141.g00534a21ce-goog

