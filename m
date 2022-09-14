Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A3CC6FA82
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Sep 2022 12:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiINMBH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Sep 2022 08:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiINMAo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Sep 2022 08:00:44 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6BF7E83F
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Sep 2022 05:00:42 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MSJkH3D3cznV6H;
        Wed, 14 Sep 2022 19:57:59 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 14 Sep 2022 20:00:40 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 14 Sep
 2022 20:00:39 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH 5/5] perf genelf: Add create_section_and_get_data helper
Date:   Wed, 14 Sep 2022 20:35:07 +0800
Message-ID: <20220914123507.23319-6-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220914123507.23319-1-shangxiaojing@huawei.com>
References: <20220914123507.23319-1-shangxiaojing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600008.china.huawei.com (7.193.23.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Wrap repeated code in helper function create_section_and_get_data, which
create section and new data by using Elf.

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
 tools/perf/util/genelf.c | 96 +++++++++++-----------------------------
 1 file changed, 25 insertions(+), 71 deletions(-)

diff --git a/tools/perf/util/genelf.c b/tools/perf/util/genelf.c
index 953338b9e887..0aa60139b9ca 100644
--- a/tools/perf/util/genelf.c
+++ b/tools/perf/util/genelf.c
@@ -155,17 +155,8 @@ gen_build_id(struct buildid_note *note, unsigned long load_addr, const void *cod
 #endif
 
 static int
-jit_add_eh_frame_info(Elf *e, void* unwinding, uint64_t unwinding_header_size,
-		      uint64_t unwinding_size, uint64_t base_offset)
+create_section_and_get_data(Elf *e, Elf_Scn *scn, Elf_Data *d)
 {
-	Elf_Data *d;
-	Elf_Scn *scn;
-	Elf_Shdr *shdr;
-	uint64_t unwinding_table_size = unwinding_size - unwinding_header_size;
-
-	/*
-	 * setup eh_frame section
-	 */
 	scn = elf_newscn(e);
 	if (!scn) {
 		warnx("cannot create section");
@@ -177,6 +168,23 @@ jit_add_eh_frame_info(Elf *e, void* unwinding, uint64_t unwinding_header_size,
 		warnx("cannot get new data");
 		return -1;
 	}
+	return 0;
+}
+
+static int
+jit_add_eh_frame_info(Elf *e, void* unwinding, uint64_t unwinding_header_size,
+		      uint64_t unwinding_size, uint64_t base_offset)
+{
+	Elf_Data *d = NULL;
+	Elf_Scn *scn = NULL;
+	Elf_Shdr *shdr;
+	uint64_t unwinding_table_size = unwinding_size - unwinding_header_size;
+
+	/*
+	 * setup eh_frame section
+	 */
+	if (create_section_and_get_data(e, scn, d))
+		return -1;
 
 	d->d_align = 8;
 	d->d_off = 0LL;
@@ -200,17 +208,8 @@ jit_add_eh_frame_info(Elf *e, void* unwinding, uint64_t unwinding_header_size,
 	/*
 	 * setup eh_frame_hdr section
 	 */
-	scn = elf_newscn(e);
-	if (!scn) {
-		warnx("cannot create section");
+	if (create_section_and_get_data(e, scn, d))
 		return -1;
-	}
-
-	d = elf_newdata(scn);
-	if (!d) {
-		warnx("cannot get new data");
-		return -1;
-	}
 
 	d->d_align = 4;
 	d->d_off = 0LL;
@@ -248,7 +247,7 @@ jit_write_elf(int fd, uint64_t load_addr, const char *sym,
 	      void *unwinding, uint64_t unwinding_header_size, uint64_t unwinding_size)
 {
 	Elf *e;
-	Elf_Data *d;
+	Elf_Data *d = NULL;
 	Elf_Scn *scn;
 	Elf_Ehdr *ehdr;
 	Elf_Shdr *shdr;
@@ -288,17 +287,8 @@ jit_write_elf(int fd, uint64_t load_addr, const char *sym,
 	/*
 	 * setup text section
 	 */
-	scn = elf_newscn(e);
-	if (!scn) {
-		warnx("cannot create section");
+	if (create_section_and_get_data(e, scn, d))
 		goto error;
-	}
-
-	d = elf_newdata(scn);
-	if (!d) {
-		warnx("cannot get new data");
-		goto error;
-	}
 
 	d->d_align = 16;
 	d->d_off = 0LL;
@@ -334,17 +324,8 @@ jit_write_elf(int fd, uint64_t load_addr, const char *sym,
 	/*
 	 * setup section headers string table
 	 */
-	scn = elf_newscn(e);
-	if (!scn) {
-		warnx("cannot create section");
+	if (create_section_and_get_data(e, scn, d))
 		goto error;
-	}
-
-	d = elf_newdata(scn);
-	if (!d) {
-		warnx("cannot get new data");
-		goto error;
-	}
 
 	d->d_align = 1;
 	d->d_off = 0LL;
@@ -370,17 +351,8 @@ jit_write_elf(int fd, uint64_t load_addr, const char *sym,
 	symtab[1].st_size  = csize;
 	symtab[1].st_value = GEN_ELF_TEXT_OFFSET;
 
-	scn = elf_newscn(e);
-	if (!scn) {
-		warnx("cannot create section");
-		goto error;
-	}
-
-	d = elf_newdata(scn);
-	if (!d) {
-		warnx("cannot get new data");
+	if (create_section_and_get_data(e, scn, d))
 		goto error;
-	}
 
 	d->d_align = 8;
 	d->d_off = 0LL;
@@ -413,17 +385,8 @@ jit_write_elf(int fd, uint64_t load_addr, const char *sym,
 	}
 	strcpy(strsym + 1, sym);
 
-	scn = elf_newscn(e);
-	if (!scn) {
-		warnx("cannot create section");
-		goto error;
-	}
-
-	d = elf_newdata(scn);
-	if (!d) {
-		warnx("cannot get new data");
+	if (create_section_and_get_data(e, scn, d))
 		goto error;
-	}
 
 	d->d_align = 1;
 	d->d_off = 0LL;
@@ -446,17 +409,8 @@ jit_write_elf(int fd, uint64_t load_addr, const char *sym,
 	/*
 	 * setup build-id section
 	 */
-	scn = elf_newscn(e);
-	if (!scn) {
-		warnx("cannot create section");
-		goto error;
-	}
-
-	d = elf_newdata(scn);
-	if (!d) {
-		warnx("cannot get new data");
+	if (create_section_and_get_data(e, scn, d))
 		goto error;
-	}
 
 	/*
 	 * build-id generation
-- 
2.17.1

