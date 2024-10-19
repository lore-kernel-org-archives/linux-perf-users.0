Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5151CC890;
	Sat, 19 Oct 2024 07:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729323674; cv=none; b=ifC+k0TYmzwjiAvtXoLR0XvUMzRq00nedCRFxUeUDb+symdLbyEg1ERPdqQ7SpjeC+9ltqHj5LM67UTLK+FGDlQfrHM77yRmZ0+b5aXxCM6BIW3Tj9Uca88w7Y+NWkhgmAw8nNn9erghDmfEeu2gGK2FtXmgxlxc1j999tIf0D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729323674; c=relaxed/simple;
	bh=/z1Rf9LVaQme036a/dTApgdr/84PAmRLdRIrBShU6Do=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xvw59lRUPA1GEOVG1/zlvGq/zlvupn4dNAm+yiTqfwl66e0gus/QcejFjGb8WOMTsJ8LshpdsFJcV1v4Mu53Bsaml4cwrR7b8dzMlQI7Gr3m489OGTw7osMJPBMLe1PfTcrdJ6bW8VzQRhJ5P4D4wb9FSpN0bU7ddTcC/7HYDno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XVtgT2VN1z1HKyV;
	Sat, 19 Oct 2024 15:36:53 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id C65F6140114;
	Sat, 19 Oct 2024 15:41:09 +0800 (CST)
Received: from lihuafei.huawei.com (10.90.53.74) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 19 Oct 2024 15:41:09 +0800
From: Li Huafei <lihuafei1@huawei.com>
To: <namhyung@kernel.org>, <atrajeev@linux.vnet.ibm.com>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <kjain@linux.ibm.com>, <sesse@google.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lihuafei1@huawei.com>
Subject: [PATCH v2 3/3] perf disasm: Fix not cleaning up disasm_line in symbol__disassemble_raw()
Date: Sat, 19 Oct 2024 23:41:57 +0800
Message-ID: <20241019154157.282038-3-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241019154157.282038-1-lihuafei1@huawei.com>
References: <20241019154157.282038-1-lihuafei1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf500004.china.huawei.com (7.202.181.242)

In symbol__disassemble_raw(), the created disasm_line should be
discarded before returning an error. When creating disasm_line fails,
break the loop and then release the created lines.

Fixes: 0b971e6bf1c3 ("perf annotate: Add support to capture and parse raw instruction in powerpc using dso__data_read_offset utility")
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
Changes in v2:
 - Break directly in the loop when it fails, then free disasm_line.
---
 tools/perf/util/disasm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 8a24e31a1534..250cc5ef4762 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1770,7 +1770,7 @@ static int symbol__disassemble_raw(char *filename, struct symbol *sym,
 		sprintf(args->line, "%x", line[i]);
 		dl = disasm_line__new(args);
 		if (dl == NULL)
-			goto err;
+			break;
 
 		annotation_line__add(&dl->al, &notes->src->source);
 		offset += 4;
-- 
2.25.1

