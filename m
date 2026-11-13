Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590278;
	b=Zj7nBFKO3+3iH9NdC8bv5sjDodmZEoNrI1KkkkYftaCLq/74wOcPF3Z2TfA3uduxDBeI
	 67Q9MB+5621dLGjztoFng0/6vtDlPCHUK4yzcLeNPMh5+0G5JXv1x4DuusmXUSVqrGbYZ
	 1CYEThW6DAFeiarPk4fZ5PcIZq8VI9Pf7M6kvCUh58GSi+SuM+75s4qj5FTL/18Kx5ly4
	 7kDp3kPVUtvAqlffm7HQxWUrtHvw+WlFPeMzq6vAgBZNNFfloEeurv4R/NUSf9DXtHK5r
	 SFKO/WDCQ3GBRCIkui45zTGYRmhkGANX+UxJ8lDVqOGKmE/Hy6w68j7eJ/3Vee0piFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590278;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=eaeK/WXL0q4XXafa02fuWe5eh2hPzq9uFX73QVahXC4=;
	b=g7INVgR6lrWKs6ZIWEqHC8ICNv92xhReNNl39eH2WREacNYuN9b6wZe8L6/2JfqaU9yn
	 wMinvf5oa+YJgkpcomCp+q45ctC0xq3cA4au0PfVokpeXFyqbXXFf1AeX+/aKtloNMGVr
	 5D63XQERJ+I0xIEoDTvjz43C4S2mEz/BHRnQHa0BZxUtS5XnuBe+fOdLsxkuG4rv2Eztl
	 v1tDEUqgMsyJrlbwqizLOJiPnm3vSg86XatsiFuN5OEhamr2QEXMcUniuugCn4mPuIEYE
	 CUwyd3oArTHcl6QxzKhZjKZnjhcXXdm5nmcEA9ewM2Vtm705GpHCTZ5dzNpANymvp8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="Q/AP4ymh";
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF7D606B21D
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAF7D606B21D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Q/AP4ymh
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso1786945eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 09:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794590277; x=1795195077; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eaeK/WXL0q4XXafa02fuWe5eh2hPzq9uFX73QVahXC4=;
        b=Q/AP4ymhdS+SNTMcdmYpGp4x+aIU391FdBW2yMWa93oVwkK73Ih2kVP8xn1pumQnZF
         v+Uroj35f287wIga8XdQCC+tM7QMclyjnamrEb5Rdyyy1V3GyKOMXxBSr2qeU7QqeRP8
         5jR85+dvGukqQGsuWlmXNYk5UerqYrwL6ovCCUx/1B4bc7JGO5LwFN+qK6bC/isuxLEd
         9gn8e3oJ6jHZHSXlO+BzG9feX8jrMJiEnKpX6CNsm77Lac/q9kk8Ue5tMH1AVZ4WuoWF
         9YXNez5yr+daMWvRmSfMTuxKh5EJK6P8FSsb4LPhUROK/9qo+Q99cwiwFeikRG4IZDcw
         HBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590277; x=1795195077;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eaeK/WXL0q4XXafa02fuWe5eh2hPzq9uFX73QVahXC4=;
        b=O41Bd5JSUs646QjYMlOv844aekZw2HTR+InmwIfgeh3xqwsNBCOmaZPRPVrmUcbSKn
         IxcPlDNmnNLFECQI2DXekQJQ3enVtg8yKwkkUqxEnUHMctnmG6P8WEvBI3h+DyITcu8W
         N5TIsrKwa4u24YX8XT1JwC5lVo+NGzOtIAqQ5YerWacJCzGNtzS1/QNkCao8evGN8TlV
         f/4ooMhOdncPGTN1pYCOL0vXjvCGDM54rNtHR6FqXYmFQphw1cDxM8vZWiP8e0aHU3wm
         SekclKPudBg4wHAQ1gmOt6krEpITCiP5O+MH6jUOfJ302tgExm4aiiCek+yjMK4WLUON
         MClQ==
X-Forwarded-Encrypted: i=1; AL+hErF+9ECsKVxkXjZQxUu1z3beT1m/FgzeGweSW0iQ594JHptZYdU1faSXNdgBOJE/jIpVur3I9U4jalxn3RizaCIK@vger.kernel.org
X-Gm-Message-State: APuU4Z8eIrzxTEZ+IhI1ewvcZub6C3lViNu8mNYpmj8kE//7vuSScG/i
	EJ4yCovY2O130yyTvC/fTc2RugyAcx+lBbRrkYxXIWT+61+RmD0hLz6ZTEYyE+D/5pRQjlRj/yh
	LF2sYTsTqEg==
X-Received: from dli14-n2.prod.google.com ([2002:a05:7022:28e:20b0:184:6cc9:b13c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7023:a88:b0:1b2:611a:89fd
 with SMTP id a92af1059eb24-1b50315f753mr3016164c88.45.1794590276616; Fri, 13
 Nov 2026 09:17:56 -0800 (PST)
Date: Fri, 13 Nov 2026 09:17:12 -0800
In-Reply-To: <20261113171734.2188066-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261110220803.2503416-1-irogers@google.com> <20261113171734.2188066-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113171734.2188066-2-irogers@google.com>
Subject: [PATCH v4 01/23] perf machine: Fix NULL deref on allocation failure
 in __machine__findnew_thread()
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, haghdoost@uber.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

When threads__findnew() fails to allocate a struct thread (or fails to
insert it into the shard hashmap and no concurrent thread inserted the
tid), it returns NULL with *created == false.

In __machine__findnew_thread(), the !created branch unconditionally
passed th to machine__update_thread_pid(), which immediately
dereferenced NULL via thread__pid(th) instead of propagating NULL to the
caller.

Guard the machine__update_thread_pid() call with 'else if (th)' so
allocation failure returns NULL cleanly.

Fixes: d436f90a64f3 ("perf machine: Move machine's threads into its own abstraction")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 5eb5efa4eb90..dc0aaac992f9 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -568,8 +568,9 @@ static struct thread *__machine__findnew_thread(struct machine *machine,
 			thread__put(th);
 			return NULL;
 		}
-	} else
+	} else if (th) {
 		machine__update_thread_pid(machine, th, pid);
+	}
 
 	return th;
 }
-- 
2.56.1.703.gf848ed807c-goog

