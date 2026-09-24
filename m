Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D143542A168
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 22:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790289037; cv=none; b=dVT7b8ZNWRdFC4nIFxXFcSHJlZ6gaf2wmA9y47LN6/xpMz24gnN566XYEobzVh5us/EKuY9JeD98MaqAX/5h2gk2kJvVE3HEN7Qr9aoFNxo0QwzfINhxaGpxZcM4/FGjcIUQT4NrnbgZ1B1BvpcnXSrK3NP5A/1LUk/0WxcgGzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790289037; c=relaxed/simple;
	bh=S2DJGdVr6v5Y5TUjEhvZ3fN3d0zkz4DDClA2LrR7N28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJmLKM0T3dfwjcmJvEU/CKDLact1hFcQX9PAvIuCMNiofEFj7h+bL7BYXRKmX8RsDxPBAWSNHzKuZt31BGZGoPWXCNZsHOhI3Z+4pslmn32w09RPHBOXTXF8JTZTtHTKuA5Yqje1eXqrHpOiF4Vrg4nuGKRWoCbgMbj30+mikhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MVrAbexC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MVrAbexC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790289034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hg6oKoyjAsyjw1862xNEzqJdWhBiFpZGbZ35yjUq8HE=;
	b=MVrAbexCcy1drL4yxMSlbdmSxhazNmYrRHarS6QSiOYazBL9xtHEBtTiAvZl/X59Jaj55g
	2r/I20b0gcEP6bZfKtJYRwbEqdgiIwoF1N9u1yioRLFd0XRRniweox3OXsvBZnPeO/mjt6
	p7RMXl8geRQ6T2jusbdQj8tx6mtu718=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-Pok8svoDOr2rTN6aeBJZhQ-1; Thu,
 24 Sep 2026 18:30:32 -0400
X-MC-Unique: Pok8svoDOr2rTN6aeBJZhQ-1
X-Mimecast-MFC-AGG-ID: Pok8svoDOr2rTN6aeBJZhQ_1790289031
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B5271193E8B1;
	Thu, 24 Sep 2026 22:30:31 +0000 (UTC)
Received: from Carbon.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5E55C1800370;
	Thu, 24 Sep 2026 22:30:30 +0000 (UTC)
From: Michael Petlan <mpetlan@redhat.com>
To: linux-perf-users@vger.kernel.org,
	irogers@google.com,
	namhyung@kernel.org
Cc: acme@redhat.com
Subject: [PATCH 1/2] perf test attr: Propagate the return value from the test to the wrapper
Date: Fri, 25 Sep 2026 00:30:26 +0200
Message-ID: <20260924223027.799654-2-mpetlan@redhat.com>
In-Reply-To: <20260924223027.799654-1-mpetlan@redhat.com>
References: <20260924223027.799654-1-mpetlan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Currently it does not matter what the python script actually returns,
the test always passes, as the $err variable is always 0.

Fix that.

Fixes: 8519e4f44c2af72214dc029f0334be068466e71f perf test: Add a shell wrapper for "Setup struct perf_event_attr"

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/perf/tests/shell/attr.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/shell/attr.sh b/tools/perf/tests/shell/attr.sh
index 5a4e43b2471d..307e1535795a 100755
--- a/tools/perf/tests/shell/attr.sh
+++ b/tools/perf/tests/shell/attr.sh
@@ -18,5 +18,6 @@ trap trap_cleanup EXIT TERM INT
 shelldir=$(dirname "$0")
 perf_path=$(which perf)
 python "${shelldir}"/lib/attr.py -d "${shelldir}"/attr -v -p "$perf_path"
+err=$?
 cleanup
 exit $err
-- 
2.52.0

