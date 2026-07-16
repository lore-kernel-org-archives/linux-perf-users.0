Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E984732A3FF
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 07:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784187481; cv=none; b=kA5qAbJRynchhMvhAitOxOH1WbCG5c/7qXTfr9gPzG1stfDZNHFjti4sEQyThpZqNTCzhpYOUe4w2Q5DswCpJVF9I8qpiXR0+klws8ScCg5oN/vtd/weHSIxeY67G/hTSfwCxqmVQ6RXX5k/Jc8HG0eUeJdBZSqHuKtXSbh7vT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784187481; c=relaxed/simple;
	bh=O+2tYg//sQkpFW7AjD9P9NKSGgVrB2yW4tacodgQO+s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RFsQmT0axJl2o2qlGZ8rjvCtE2D6Kom60IYp3nx5NyQx0AIuPKY1uzQ5ufPlQXE5ZHK6ygX3F1v3HukqhmA9MNf7ShFQ83/8zDJ0FMH4A6PcteAcfb+RmiLUrpTdWVYubMtJrnQhShPYekyCBXTjnBsHddOY6PquE0jx0X/NqQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XMzQZudP; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XMzQZudP"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c88ad1558f4so1580816a12.2
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 00:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784187479; x=1784792279; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3+SHrjzMNBAVLPRznlS3NCDcxddtMolQIDQ3e8u2Jnw=;
        b=XMzQZudPYnZI6S4hdTDLaILSUOAORkh8MeOpXki4pfpZVv9c/3YwoCdzSSzTdlHQda
         tP6JmX1jZaeSlW5cTXVWmZLonTx6m2XSSojnB6kGtngQlqnkTtBOXiwYhkBcu0PImb+1
         +J+xJuf1UnNvMqOPOkSRIt0SbAEzkYwnI6Zpqvci4dgiGnFjJQYuWx/Kh0adpFMIwXGa
         FNCdCD+wWTMpgMfva+LLGKXLJRUwwCLbuEhOcclvtWrQhOKgnT6M0h9BsZvw21Y7Yvof
         gKVvHN+mOQ8mX+6ibl58ZQBBhMCcpeOMM0pQvuN+d8dPEAoE7CohgTaBuvcCUVF1KVbI
         L3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784187479; x=1784792279;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3+SHrjzMNBAVLPRznlS3NCDcxddtMolQIDQ3e8u2Jnw=;
        b=RVMSl0LSoy6wtFM8ShF20A4hiASQpfqN5lpXZPeKEDSsCfo0DF1J0gvv19xRo1BLAF
         qJZUplPi+7gBCkqavvf3q0ipUAZY/cbfW58OiZeInN/l7Jg3tuvxPBEHh20fDqfGeT8p
         L7QIo06q+AtQ7B6z10kl6+FeOkWsAJc0gn5H8HDp95Lzu8sGlPrtb1mfNrbjjaZUj4Vf
         WRDvcmRqtvIYCCOOiQs2HLyzMk9QrW858tN8Zh6lMrcYVmKGaH+V1lAS5gMHDJTWDl5m
         kM4VAhqvHDJhv/aRrvB32njbIPD/PcP/1VkVzYePhSilZVCQoxH8xfFECwAXlvauV4LU
         9q/g==
X-Forwarded-Encrypted: i=1; AHgh+RqA2frxCCaxKPxM+WC8nOwKxdizG1zJESWje1pEJ1uo4n/Viv0rM5aEQBSk+YS+wbCqnJVDSjkPpepLIuOPxyXw@vger.kernel.org
X-Gm-Message-State: AOJu0YzA/X22XE8UwZ7UfbwIWr+qpynhpyE/AlbazlEW5i6dCMyGWpq0
	T8OVL6SlWRsQV/BCLeB3xNDwq13eSTZBfEp8mX6+jA0cN7NDCMGvsoNnmvV6v/LyV1kMfINZWXF
	2XA9WdvsLvg==
X-Received: from dycpv7.prod.google.com ([2002:a05:7300:de07:b0:314:44:bbdd])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a126:b0:3b3:f46:1ef3
 with SMTP id adf61e73a8af0-3c357553e67mr11440292637.41.1784187478977; Thu, 16
 Jul 2026 00:37:58 -0700 (PDT)
Date: Thu, 16 Jul 2026 00:37:53 -0700
In-Reply-To: <178383937332.3162711.15710064516636108862.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <178383937332.3162711.15710064516636108862.b4-ty@kernel.org>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260716073753.567782-1-irogers@google.com>
Subject: [PATCH v2] perf record: Fix destructor invocation and event counting
 in fdarray__filter
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org, acme@kernel.org
Cc: abyssmystery@gmail.com, adrian.hunter@intel.com, irogers@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Fix the API-level fdarray filtering logic in fdarray__filter() following
the integration of the system-wide recording teardown fix. Rather than
bypassing the evaluation loop entirely for nonfilterable file
descriptors (which accidentally skips calling registered entry
destructors for control pipes and wakeup FDs, while creating poll storms
and reference leaks for system-wide events that also have nonfilterable
set), separate the lifecycle and masking logic.

Reorder the filtering sequence so that registered entry destructors are
safely executed first for all file descriptors. Then, utilize the
fdarray_flag__non_perf_event flag to perfectly distinguish and bypass
destructive file descriptor zeroing (.fd = -1) and revents mask
clearing for background control pipes and timers. This allows system-wide
event file descriptors to be correctly destroyed, zeroed, and filtered out upon
receiving POLLHUP/POLLERR signals without triggering busy loops, while safely
preserving control pipe teardown signaling and destructors.

Fixes: fb4751e79c45 ("perf record: Fix teardown hang on system-wide multi-threaded sessions")
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/fd/array.c    | 6 +++---
 tools/perf/builtin-record.c | 4 +++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
index 16a047f1906e..92d9a3fb652c 100644
--- a/tools/lib/api/fd/array.c
+++ b/tools/lib/api/fd/array.c
@@ -115,9 +115,6 @@ int fdarray__filter(struct fdarray *fda, short revents,
 		return 0;
 
 	for (fd = 0; fd < fda->nr; ++fd) {
-		if (fda->priv[fd].flags & fdarray_flag__nonfilterable)
-			continue;
-
 		if (!fda->entries[fd].events)
 			continue;
 
@@ -125,6 +122,9 @@ int fdarray__filter(struct fdarray *fda, short revents,
 			if (entry_destructor)
 				entry_destructor(fda, fd, arg);
 
+			if (fda->priv[fd].flags & fdarray_flag__non_perf_event)
+				continue;
+
 			/*
 			 * Set fd to -1 so poll() ignores this entry; otherwise
 			 * POLLHUP/POLLERR are still reported for events=0 fds
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index f58d7e3c7879..c6644dab1cfb 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1242,7 +1242,9 @@ static int record__alloc_thread_data(struct record *rec, struct evlist *evlist)
 				goto out_free;
 			}
 			ret = fdarray__add(&thread_data[t].pollfd, thread_data[t].pipes.msg[0],
-					   POLLIN | POLLERR | POLLHUP, fdarray_flag__nonfilterable);
+					   POLLIN | POLLERR | POLLHUP,
+					   fdarray_flag__nonfilterable |
+					   fdarray_flag__non_perf_event);
 			if (ret < 0) {
 				pr_err("Failed to add descriptor to thread[%d] pollfd\n", t);
 				goto out_free;
-- 
2.55.0.141.g00534a21ce-goog

