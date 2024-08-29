Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A3D22339
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Aug 2024 11:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724930992; cv=none; b=kbjj/L0FAgKsV1sw2tbImL6h1AMchCz5RObsSL+i7pc5iigUPv7osj8TdkqYMSy7yXdKJ30ERu/uKyvqr96NyDETURaDr+w6ibXELbGkoNVmEdVhViivG5xcAoa0cN1Kgi8MfUZ9Iq4qdiLy4h2U/r9ao7KmIZhL4QQchu5K4kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724930992; c=relaxed/simple;
	bh=blfyFu94Uht+4T8DOP/fpEHKhmPQFeyLKvveZ4LXCUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kZXiDIDOobuGrp+PGeUp/1vsT4eUFiXfmahYaIxlEqQVTj/LjmvgCScYvmgRfvNo2WA2flQKvn/cOefTIgyNxOTF80m26+nSyKma3SMzoD7YBRmRfgTEtYjQ4GuGvQfQ3wfGPxympajo/L6DQqXz9Xs8mcYCLv7uRxW1s/A4d78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ek+/mucO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ek+/mucO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724930990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dDKiY0Smj2HwjUZ28qBH3n7v9fZbG6GuPhnRCI8tJK8=;
	b=Ek+/mucOJR/iNlPv43CWb3g1SydTnQJVniS8b9boU9IoAyXc3DHZRLblftgiKLl9UQZCCd
	sLW5+hh9QZ1ibU036ZDkG63aKNag0ga6B0n+12kVEWoGvjDJvZFyQEGFWJxrnX3b5ddbAH
	Z+wHjhJMlMd1ZZCXYOeG+S/tpm1zySk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-486-GEsMoUpVP7unwWvTtr7M9w-1; Thu,
 29 Aug 2024 07:29:47 -0400
X-MC-Unique: GEsMoUpVP7unwWvTtr7M9w-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9DF391955BE7;
	Thu, 29 Aug 2024 11:29:45 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.56])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA7B73001FC3;
	Thu, 29 Aug 2024 11:29:42 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	acme@redhat.com,
	namhyung@kernel.org
Cc: mpetlan@redhat.com,
	irogers@google.com,
	atrajeev@linux.vnet.ibm.com
Subject: [PATCH v2 01/11] perf tests shell: Skip base_* dirs in test script search
Date: Thu, 29 Aug 2024 13:29:37 +0200
Message-ID: <20240829112937.12573-1-vmolnaro@redhat.com>
In-Reply-To: <Zs-LEEutfp0hkjh5@x1>
References: <Zs-LEEutfp0hkjh5@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Michael Petlan <mpetlan@redhat.com>

The test scripts in base_* directories currently have their own drivers
that run them. Before this patch, the shell test-suite generator causes
them to run twice. Fix that by skipping them in the generator.

A cleaner solution (for future) will be to use the directory structure
idea (introduced by Carsten Haitzler in 7391db645938 ("perf test:
Refactor shell tests allowing subdirs")) to generate test entries with
subtests, like:

$ perf test list
[...]
97: perf probe shell tests
97:1: perf probe basic functionality
97:2: perf probe tests with arguments
97:3: perf probe invalid options handling
[...]

There is already a lot of shell test scripts and many are about to come,
so there is a need for some hierarchy.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
---
 tools/perf/tests/tests-scripts.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-scripts.c
index e2042b3682..01971e9974 100644
--- a/tools/perf/tests/tests-scripts.c
+++ b/tools/perf/tests/tests-scripts.c
@@ -222,6 +222,8 @@ static void append_scripts_in_dir(int dir_fd,
 			if (!S_ISDIR(st.st_mode))
 				continue;
 		}
+		if (strncmp(ent->d_name, "base_", 5) == 0)
+			continue; /* Skip scripts that have a separate driver. */
 		fd = openat(dir_fd, ent->d_name, O_PATH);
 		append_scripts_in_dir(fd, result, result_sz);
 	}
-- 
2.43.0

