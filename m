Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4323715748F
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jul 2024 11:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719918799; cv=none; b=rWqBgvEpkwwCmK8IVsZx+XiFb5mwqqXe8lOcu2j/pQcP2RBuHzGMFzcm65IgRmfPBWhJ8NrRvSJZrKAjTZuJhLevqFBkTG1iZ6OlnodWm31QLCJUotRNNUgWbpZL2FZszNpWHk2vIg1JhnzkctSsXA2FlHmxIwe2zZcBKVJNDsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719918799; c=relaxed/simple;
	bh=O2s0QnYbMvG13zftpJjGXui7XWE63pUN/bJaA0gtlhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t1SdTb9k6NEYkQ2XBs5PIgduwo+CHVgg/qgQRFaawQWCHZ2wl5OY7ymcMtn6zTKxItYQ9UADtyxzyePTM/nrNNXOPnpPiPGDxXVJV4JGH6ehSJxWCK+VfW/RMLfYRzvbCmPr5KfY5xxEFbwmEkmqSpOOrj3TLL6eBtt4FS2xy0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gXntNrNP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gXntNrNP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719918797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QmE54Mg99ZwOjj8Zyhv+goM8d4s3EWEheadAqt82gQY=;
	b=gXntNrNPMGakb2bv/vckZL3B1QFd9yqVkVg8ez5x7r5/4te44uzYN+QUIcH5z4XSrTcVRI
	7ARhPDlNXMkl0FYyTPiMxu1Lokh1uCrATYZBxKhc0t67sTu5ZrWTpqMBktPxGoORAO50ga
	3WcJVxtEkZ+OnywWiWvT73rcxo1HAgw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-7-zfkKgoXqOumnmrTz7F-dpQ-1; Tue,
 02 Jul 2024 07:13:14 -0400
X-MC-Unique: zfkKgoXqOumnmrTz7F-dpQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 26DDE194511A;
	Tue,  2 Jul 2024 11:13:13 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.179])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C33BD1956089;
	Tue,  2 Jul 2024 11:13:09 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@redhat.com,
	namhyung@kernel.org
Cc: acme@kernel.org,
	mpetlan@redhat.com,
	irogers@google.com,
	atrajeev@linux.vnet.ibm.com,
	masami.hiramatsu.pt@hitachi.com
Subject: [PATCH v2 01/11] perf tests shell: Skip base_* dirs in test script search
Date: Tue,  2 Jul 2024 13:08:40 +0200
Message-ID: <20240702110849.31904-3-vmolnaro@redhat.com>
In-Reply-To: <20240702110849.31904-1-vmolnaro@redhat.com>
References: <Zn3n0JwfdfFdjbzj@google.com>
 <20240702110849.31904-1-vmolnaro@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

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

