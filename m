Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A681A9F82
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jul 2026 04:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783486616; cv=none; b=SJxtY8dWtVH1QO89UrjDnlHC2SKQKQxzjDynF/2f/Icj46c2ttXposK14Mo2v/4ZBcJgzs9XNGjO2PETjGmJfQOZ77R4DnmixAGRn/T/NCeqbM4YjEHqp1EAyUOlo+Ys9f3+zkm6cZeLIS5hkQoGbPoNXzaeP3j+6Vnck0S9ht8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783486616; c=relaxed/simple;
	bh=WzdntbdTfCEek5erkl87V4V/BLMaK+hZ7jUKZgqumgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pguh1d6igHTFto6ryx+UY4Erpdg6Qp78tC04fdSFaE4vdwNshzyakaGuITG09taPvcvXTS25T7jELPLKvI1i0sgNgi+G4SGG7hlvWLJP6OrPIfJ8B3cVnKw1BjsfAFA71vv25+npKnUf3imgVw9JkSAbuo3R3Jne8jEVIolz7F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CB+Ba+fw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CB+Ba+fw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783486613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mpwu9RABOOk8nRyzzv4Qi8b8SioAAWeTP8aY2WL7YWM=;
	b=CB+Ba+fw3XWPwBdHZyIFce1N7uhIOv8ueWMovRv9i81PlrmNrRtqjlO63cbUsvuHNFgxvX
	gun1NwDcrQG+4qHwBMDdv6ktUpFJbcfEE1xfpPGmBNDpzbYoPlDGK9rD/8gCPsZHMYF2gf
	e7bQK4sL4CdmVgRe4zdG+OS3Q3VYNzA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-Mw-Les9MP1eN6pNrRPp0_Q-1; Wed,
 08 Jul 2026 00:56:50 -0400
X-MC-Unique: Mw-Les9MP1eN6pNrRPp0_Q-1
X-Mimecast-MFC-AGG-ID: Mw-Les9MP1eN6pNrRPp0_Q_1783486608
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A3591195604E;
	Wed,  8 Jul 2026 04:56:47 +0000 (UTC)
Received: from tallison-mac.redhat.com (unknown [10.22.81.130])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BA9D218005B5;
	Wed,  8 Jul 2026 04:56:45 +0000 (UTC)
From: Trevor Allison <tallison@redhat.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	tallison@redhat.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] perf build: Preserve EXTRA_CFLAGS when building in-tree libbpf
Date: Wed,  8 Jul 2026 00:56:04 -0400
Message-ID: <20260708045606.43649-2-tallison@redhat.com>
In-Reply-To: <20260708045606.43649-1-tallison@redhat.com>
References: <20260708045606.43649-1-tallison@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The libbpf sub-make passes EXTRA_CFLAGS="-fPIC", replacing the
parent EXTRA_CFLAGS.  Append -fPIC instead, since libbpf.a is linked
whole-archive into perf.

Signed-off-by: Trevor Allison <tallison@redhat.com>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 2b53d9e0c73b..a59ed1d70ecc 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -706,7 +706,7 @@ $(LIBAPI)-clean:
 $(LIBBPF): FORCE | $(LIBBPF_OUTPUT)
 	$(Q)$(MAKE) -C $(LIBBPF_DIR) FEATURES_DUMP=$(FEATURE_DUMP_EXPORT) \
 		O= OUTPUT=$(LIBBPF_OUTPUT)/ DESTDIR=$(LIBBPF_DESTDIR) prefix= subdir= \
-		EXTRA_CFLAGS="-fPIC" $@ install_headers
+		EXTRA_CFLAGS="$(EXTRA_CFLAGS) -fPIC" $@ install_headers
 
 $(LIBBPF)-clean:
 	$(call QUIET_CLEAN, libbpf)
-- 
2.50.1 (Apple Git-155)

