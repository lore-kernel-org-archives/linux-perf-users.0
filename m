Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99213ECAAD8
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Sep 2022 08:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbiIWILe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Sep 2022 04:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbiIWILd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Sep 2022 04:11:33 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E653C12C1C0
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Sep 2022 01:11:31 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MYlB0732Tz1P6rn;
        Fri, 23 Sep 2022 16:07:20 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 16:11:30 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 23 Sep
 2022 16:11:29 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>
CC:     <yao.jin@linux.intel.com>, <shangxiaojing@huawei.com>
Subject: [PATCH v2 5/6] perf genelf: Add create_section_and_get_data helper
Date:   Fri, 23 Sep 2022 16:45:39 +0800
Message-ID: <20220923084540.25849-6-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220923084540.25849-1-shangxiaojing@huawei.com>
References: <20220923084540.25849-1-shangxiaojing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
index ed28a0dbcb7f..3ee048ca5a40 100644
--- a/tools/perf/util/genelf.c
+++ b/tools/perf/util/genelf.c
@@ -157,17 +157,8 @@ gen_build_id(struct buildid_note *note, unsigned long load_addr, const void *cod
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
@@ -179,6 +170,23 @@ jit_add_eh_frame_info(Elf *e, void* unwinding, uint64_t unwinding_header_size,
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
@@ -202,17 +210,8 @@ jit_add_eh_frame_info(Elf *e, void* unwinding, uint64_t unwinding_header_size,
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
@@ -250,7 +249,7 @@ jit_write_elf(int fd, uint64_t load_addr, const char *sym,
 	      void *unwinding, uint64_t unwinding_header_size, uint64_t unwinding_size)
 {
 	Elf *e;
-	Elf_Data *d;
+	Elf_Data *d = NULL;
 	Elf_Scn *scn;
 	Elf_Ehdr *ehdr;
 	Elf_Shdr *shdr;
@@ -290,17 +289,8 @@ jit_write_elf(int fd, uint64_t load_addr, const char *sym,
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
@@ -336,17 +326,8 @@ jit_write_elf(int fd, uint64_t load_addr, const char *sym,
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
@@ -372,17 +353,8 @@ jit_write_elf(int fd, uint64_t load_addr, const char *sym,
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
@@ -415,17 +387,8 @@ jit_write_elf(int fd, uint64_t load_addr, const char *sym,
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
@@ -448,17 +411,8 @@ jit_write_elf(int fd, uint64_t load_addr, const char *sym,
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

