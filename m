Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930BA7866F
	for <linux-perf-users@vger.kernel.org>; Wed, 31 Jan 2024 11:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706701211; cv=none; b=GHDu7WIyw0a2FnyqhFoIUXD3+Fa2ArqVlFzuXSlANGMPo0NQ7XPGx8Z5OHExKA+Pek95H48GxmBCioElcstGamEgsBbiHjvaDem16JyD9cH2olM8AtcDdgrT2LoMLZmmu7uVFE8Z/+8J50K1Y0tieCiE6w7OGrs4sIJ0sg837DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706701211; c=relaxed/simple;
	bh=tdZSc2ThrOyqHnTAGQa8+o1O6rxrjGpZMprNKQ+46so=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=X2yIWmf98D/GXHm9RJ0GmeZiCqKMhAdXbXRH6OiZmkbWWnIGEoSkgrss1ufn+XSkQX8mR6z8m9kuRfBBAMOjZhLjXl/KmLCXYhmRD9j9PrvTGpU7GNGuARiTtxcbAwWLoz5j6T/WoproPCWTKl+DGZpaR9xiy+R6JbKqcD+d6Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FBgY7aK7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FBgY7aK7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706701208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:in-reply-to:in-reply-to:references:references;
	bh=V9gY4aoN7tguc1Qz6mgtVQPkCer9dP2uBVs1y+KkMY8=;
	b=FBgY7aK7A1b7QlWLm5jplYS3ZDGUc4yVz1mKwbr9kWT6Th0HOW5VJqL4hmGTEd21RG1Yh5
	1vUkMwzCja6O0RbDg5kL/Ib9m7h+hbBVnmD9VMc0W346hhfncY+/bx/Gsu8HPt6CjPcpsX
	WX93EG2/3CYB7VaAksUgx3Js8xAPdqo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-s7o-weglOR60Z5l5S0Xp7Q-1; Wed, 31 Jan 2024 06:40:05 -0500
X-MC-Unique: s7o-weglOR60Z5l5S0Xp7Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 938AB835389;
	Wed, 31 Jan 2024 11:40:04 +0000 (UTC)
Received: from Diego.redhat.com (unknown [10.39.208.45])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4218EC1ED63;
	Wed, 31 Jan 2024 11:40:03 +0000 (UTC)
From: Michael Petlan <mpetlan@redhat.com>
To: linux-perf-users@vger.kernel.org,
	vmolnaro@redhat.com,
	acme@redhat.com,
	acme@kernel.org
Cc: mhiramat@kernel.org
Subject: [PATCH 7/7] perf testsuite: Install kprobe tests and common files
Date: Wed, 31 Jan 2024 12:39:51 +0100
Message-Id: <20240131113951.17077-7-mpetlan@redhat.com>
In-Reply-To: <20240131113951.17077-1-mpetlan@redhat.com>
References: <20240131113951.17077-1-mpetlan@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/perf/Makefile.perf | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 058c9aecf608..7811a4385586 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1029,6 +1029,11 @@ install-tests: all install-gtk
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
 		$(INSTALL) tests/shell/lib/*.sh -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
 		$(INSTALL) tests/shell/lib/*.py -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/common'; \
+		$(INSTALL) tests/shell/common/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/common'; \
+		$(INSTALL) tests/shell/common/*.pl '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/common'; \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/base_probe'; \
+		$(INSTALL) tests/shell/base_probe/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/base_probe'; \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight' ; \
 		$(INSTALL) tests/shell/coresight/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'
 	$(Q)$(MAKE) -C tests/shell/coresight install-tests
-- 
2.43.0

