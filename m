Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7838313D52F
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Jun 2024 13:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719234516; cv=none; b=O60bAatgTeEO/fBC0Nz28Gz62gy0L6HBgP+TCGjR9EqYGHtgk+4LpLlU+rghcp1AOpKPnPSJl+/tQdZU8Lw37F3fKuXGpu7fwNU2k89vrTSmL2Jm2goRBZVVIRmBs4eMFQUFiDx5NPqZ55xnxE1TBdxd6fxEel0GXyogemZjI8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719234516; c=relaxed/simple;
	bh=9Eq35dwju0B8FdOtydx7GOymFpPEr5LcgOJDdfq05Yo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=dzHE+8y57kgeFNkIidY29+UK+zCvvfjDMaZ9sEDgEFwLKSSbdGJo7ZBG1UD/ANrEj+1ygEXL3bVifmayvb7seJPOHcvPcs9YofXTe39XlpKbeb18xHR2rncEFKNgccYGLNL60JDXeKNlnx3sHPVkRFbMynmmOBUIASVQ8sIjMaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RhXdr9Xj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RhXdr9Xj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719234513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:in-reply-to:in-reply-to:references:references;
	bh=7nbLEQX/oXrwaD3URmoDtdY0gezDYndJJZtHqMRoqIA=;
	b=RhXdr9XjAWuwKk46AQUjpu9br1ymUKrvhGk+P6xwgDWXemQSwYwxlseb64V3obukxeIwd6
	ICRcL6uIGYRGkgtyYl+RyQjuohEOJ794dsvyTcyIjNy93djYkUO9PQ3mAbhJJey00DLNBf
	RkSyqUdPTBdcn+rDV1XyZgKJwNqoF1E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-RBZNlMVTMuu-9Ztzep603w-1; Mon,
 24 Jun 2024 09:08:30 -0400
X-MC-Unique: RBZNlMVTMuu-9Ztzep603w-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E7F1B19560B3;
	Mon, 24 Jun 2024 13:08:28 +0000 (UTC)
Received: from Diego.redhat.com (unknown [10.39.208.42])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7B7F61956087;
	Mon, 24 Jun 2024 13:08:25 +0000 (UTC)
From: Michael Petlan <mpetlan@redhat.com>
To: linux-perf-users@vger.kernel.org,
	vmolnaro@redhat.com,
	acme@redhat.com,
	namhyung@kernel.org
Cc: acme@kernel.org,
	irogers@google.com,
	atrajeev@linux.vnet.ibm.com,
	masami.hiramatsu.pt@hitachi.com
Subject: [PATCH 01/11] perf tests shell: Skip base_* dirs in test script search
Date: Mon, 24 Jun 2024 15:07:59 +0200
Message-Id: <20240624130809.1612-2-mpetlan@redhat.com>
In-Reply-To: <20240624130809.1612-1-mpetlan@redhat.com>
References: <20240624130809.1612-1-mpetlan@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

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
---
 tools/perf/tests/tests-scripts.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-scripts.c
index e2042b368269..01971e997425 100644
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

