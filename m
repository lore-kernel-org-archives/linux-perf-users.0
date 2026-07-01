Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1883F3A5E90
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 06:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782887016; cv=none; b=lUnvfil1zxQ3TcQOGBuJMp7Gs821XAoKEGS4WuXoOQzmzJ5bgdvot3clW6aChFJtr/ZTSqjAUG47tjumk6GVYr3Zgf6i2LSAROus5ShXgi2TrLHPuD4tHq55BRJGaRcZQqrWEwb6jhb/37IP44+E/zCmkqHRYw7ASHxXPJP2Rrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782887016; c=relaxed/simple;
	bh=zhThVOahHelMd7gWF2H1MLhLvB1TPP3rfvXmeKhDX1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mp4oZDv3lUWgfM/ynTeLH0s4CHs7DZuQhv8XJDuKVWx7kyYp/YDyV8e3WDbSnAHQYnWGnlrev7ZGG1d8I2coP7kNT42FjfHzQqGU8/dPVlNXGnJa9+3ng6x7ySwlfEsZzJkyO1UmhA1KwNg9NNwW/SP8VxWVoSETfq2dtDu72u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fakSryMT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=m3NavdXG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fakSryMT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="m3NavdXG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782887014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Dn4YpE+G/XOCOtl5iA+urnXDlQSVOY4Y63+Aj/OoE04=;
	b=fakSryMTw78Oudukp+7XadgPcmRoCKnOEbNpNZJPGXbcQl8lGLRoGBwGyuTKUX1NcFC8g7
	HiRUwFvbNKQTO/exkUIHeSULRVGS/9dr604Ofc0WLrmiHLClsTfPGvPsblkwck3MyGAaWG
	6hDtKmo4HBuYoVA5QKLOGLSJ8VYMf0A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-g3MiVCXQPLmmb5hKNW9yHA-1; Wed, 01 Jul 2026 02:23:33 -0400
X-MC-Unique: g3MiVCXQPLmmb5hKNW9yHA-1
X-Mimecast-MFC-AGG-ID: g3MiVCXQPLmmb5hKNW9yHA_1782887012
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-475de65009dso209302f8f.0
        for <linux-perf-users@vger.kernel.org>; Tue, 30 Jun 2026 23:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782887012; x=1783491812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dn4YpE+G/XOCOtl5iA+urnXDlQSVOY4Y63+Aj/OoE04=;
        b=m3NavdXG+rC34zLGrUXNt5kO3UYS79WP7F8tOiAkf0SBjV/GvJSK4hViIbW0cgNM1i
         ITZizaVN2W4ehN/gAm6/vOVjQJj4L2IFmMTsKGHaYAyn7ZIUIqCkA7Sf1+X9Z8MlHd2g
         8TXZ1VtZWAQ3h7Fr9Swmz4YrDeCvmt7TWQVPt5sOKorXWCVZXhVLeM5OSLULyUJ32gJE
         C8bGzd1NeXxarhkezd2ZPgynrtRLSUXlQFjbi95TcKgAs3SnLPB+S5qK6v0I6uBEc04y
         JTCsZ09gUnRv16J4UwU2ycWkEokmBYjZQ64DbxrVSOm3O7y21E5DmubLbbscwvcufIS2
         LdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782887012; x=1783491812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dn4YpE+G/XOCOtl5iA+urnXDlQSVOY4Y63+Aj/OoE04=;
        b=JvnmehfB/WawOrw9RaP3jwOGakNoFhAUUf6ixRLcSYZLyuJLBueUJPjSYvTwj+3BNO
         IdteF+ORQWFmuYYdupQ08G4hLHiInNx6CjwvOaO1GSpQ+WPcj19vMB9jyvWBIwyUKQq4
         h+BgDbAoU/jNrjhqFWaS2Q9YD17I1iXqP93ec3Hl2U7mlZQR3x1uwHbYmLW41QHrXAZZ
         jZV1UXi2Q1/d06Y6XJ6Madx4FHsJ9NYljeOyo7gdAOLFH0GnEK4s5WAuN0A+LUWlFuFk
         fdQZjb/sbqUp82Vg+qRDQubzn+XmCOpD4mZBfdE1Cy+yyx+RbrpFRE1teQAdOSR6M7IN
         sDVQ==
X-Forwarded-Encrypted: i=1; AHgh+Roi14e/TqpOJ/141lhryEbVwb8e581qvRLdZZI3Zzpvmqsi1vQsec+cT6SsYLMD16uI7OJ0lXO/Zoaxe6bzr/ow@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3fNxvu2ULyB/1VzPejaqz4EUhgZfybpiCYV1rkdewTgX+eqyW
	M7NFKXqJ7XFyu0KFxzUTsHo9IfQhPSZ+ivsunhqOvB51N4CLKbDTuvw1vCZ3SCNRhOOKJASS5Ui
	MClVnQ25ctOxoVt7Q9LTkrNpNI8U/EUj6k9gaHNlDSpxlBP/0mVmDL67hmt7XmUC/oNlfnO8=
X-Gm-Gg: AfdE7cmeJub1BkvWrqOOd6Top+rGNMSWUpXH0nHTrwj1YS3iwaQ6Hl1AUA5WGVe/au7
	8JnMuqiOkDGWMPRr8xj+9GILjm8kPXGGU44oJWT/3S2kjiYEF+NWZUvSlerO46KyzWck8MmxSg4
	ha0NDwxbZsxeNhZyWK93892TFaosC4HDFX6GjYBXH/N8MhwQZ0ixgdFdGRh2Ql/Dz50PVu5R9Wc
	Tq/HE1yloQEY4e4aZvIgIfIRJkzeW7P1RTw+wPPqU/RrtBZV9GKmzc5OR2Ks6JSCYg33sTYd1ri
	ZVwkXBgfEjMB6oB/hZryOVbnwBKntr5BRYyWQpbdFB8HVwWhGawOKA0cCS3h/EY6sCyz
X-Received: by 2002:a05:6000:e4b:b0:472:d154:facf with SMTP id ffacd0b85a97d-4775a100e73mr312407f8f.42.1782887011726;
        Tue, 30 Jun 2026 23:23:31 -0700 (PDT)
X-Received: by 2002:a05:6000:e4b:b0:472:d154:facf with SMTP id ffacd0b85a97d-4775a100e73mr312378f8f.42.1782887011304;
        Tue, 30 Jun 2026 23:23:31 -0700 (PDT)
Received: from fedora ([213.175.37.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4756797a8besm14858051f8f.35.2026.06.30.23.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 23:23:30 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-perf-users@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] perf test amd ibs: avoid using executable heap
Date: Wed,  1 Jul 2026 08:23:21 +0200
Message-ID: <20260701062321.517351-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Making [parts of] the heap executable is dangerous and is blocked by
SELinux on Fedora/RHEL even for an unconfined user. Replace the malloc()
+ mprotect() combo with just mmap(), creating a private anonymous rwx
mapping, which only requires the more commonly allowed "execmem"
permission under SELinux (things like JIT or regex compilation need it
as well). mmap() with MAP_ANONYMOUS will give us a zeroed mapping that
begins on a page boundary, so the result is equivalent to the original
code even without a memset() or the page-alignment dance.

Verified that the test still passes on a machine with an AMD CPU that
has the "ibs" CPU flag.

Fixes: 35db59fa8ea2 ("perf test amd ibs: Add sample period unit test")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

v2: fix mmap() failure check (found by sashiko-bot)

 tools/perf/arch/x86/tests/amd-ibs-period.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/tools/perf/arch/x86/tests/amd-ibs-period.c b/tools/perf/arch/x86/tests/amd-ibs-period.c
index 6a92b3a23ed7a..32713f8fcd5c8 100644
--- a/tools/perf/arch/x86/tests/amd-ibs-period.c
+++ b/tools/perf/arch/x86/tests/amd-ibs-period.c
@@ -46,7 +46,6 @@ static int dummy_workload_1(unsigned long count)
 {
 	int (*func)(void);
 	int ret = 0;
-	char *p;
 	char insn1[] = {
 		0xb8, 0x01, 0x00, 0x00, 0x00, /* mov 1,%eax */
 		0xc3, /* ret */
@@ -59,18 +58,11 @@ static int dummy_workload_1(unsigned long count)
 		0xcc, /* int 3 */
 	};
 
-	p = calloc(2, page_size);
-	if (!p) {
-		printf("malloc() failed. %m");
-		return 1;
-	}
-
-	func = (void *)((unsigned long)(p + page_size - 1) & ~(page_size - 1));
-
-	ret = mprotect(func, page_size, PROT_READ | PROT_WRITE | PROT_EXEC);
-	if (ret) {
-		printf("mprotect() failed. %m");
-		goto out;
+	func = mmap(NULL, page_size, PROT_READ | PROT_WRITE | PROT_EXEC,
+		    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (func == MAP_FAILED) {
+		pr_debug("mmap() failed. %m\n");
+		return -1;
 	}
 
 	if (count < 100000)
@@ -93,7 +85,7 @@ static int dummy_workload_1(unsigned long count)
 	}
 
 out:
-	free(p);
+	munmap(func, page_size);
 	return ret;
 }
 
-- 
2.54.0

