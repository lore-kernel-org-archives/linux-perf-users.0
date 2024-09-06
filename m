Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8A81459FA;
	Fri,  6 Sep 2024 10:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725617942; cv=pass; b=QexGxZXiqtnFYqk3UMsM9+CcbvZZ516QEHFZ+dJO+LDAOERx2hE4gazbKrNnFvQGb04q9Kxd4EqkbEv/E2eZczD8faPvlPDqdsEMWUWjCpAsWB7dPbEb6fcrpjHfk7b2i+dMqZQdqXhUxMoGQi09406riENxbWOhlEcvfP3+FGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725617942; c=relaxed/simple;
	bh=BRWofQge9sexGsoBhj4FyqYH8VnowpJU4XLwvMOPe1w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=knVgvX4F0TFFem5viNPuU6V6Pog6OefS2po13XnHFB4j58bnEGKJzQC37oFcGVPnMXccIRSeBToJIes4sihA+eO9h+s2X6zZ9dYCRwNbqEXHd+4CsaxM91nYX06Z8F97ybTgEWa8hercV+UoLHc5BieZC7eOIxMd9wrAJge1eEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=IgMyyyps; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="IgMyyyps"
ARC-Seal: i=1; a=rsa-sha256; t=1725617921; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=oCjCSHpi+yyNyBYa+Tx9U2AxjABzZ+IwSseUgnFz56D3+h8+TGkJldaQ79wKSPT+52ke+00+gRHNuw4S1Zs51pAeUS8YfKIRDNaAs4L/GTPCcG36eE4n5P+B0PyylAmHBozU2mzyLumUntVe7XrwCVhFkA0ROhiR1yT46YCOf3o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1725617921; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=SoQoRpH+NUi/aH/TnvZGg42kAhbku15tBQ88cZXF1y0=; 
	b=in+8XObwNnFp5hMAmRcU3UECH0RhlXRBBDXlYkY/74Um1eam9unxHMX2VKlN/QsggtKrltCwNIH9ntBDWTSx67sBCjIqNtM/1OjNFXeC91fGeDwb4hJYZC54fliBfgWu1sbduIbLS7UqqQXMtzYinpqcFIJmWtUDuMFFpJ2OqS4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1725617921;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=SoQoRpH+NUi/aH/TnvZGg42kAhbku15tBQ88cZXF1y0=;
	b=IgMyyypsWp8/qexA4jlxBe4u2lIIGOP1SwDX7BiSw9hYjx7Id3peHgQ4puiCRHFz
	lSXTum+jw0A+L2Ce7n24qXlB86/BdsuVYcPKROlqVhJqWZn7kFLcuXfJW9EPXTqMNYI
	n1/JHpjTrb6R+5ocv4OKnsUgnTLQEXo52br5XzG4=
Received: by mx.zohomail.com with SMTPS id 1725617920753531.4294471338798;
	Fri, 6 Sep 2024 03:18:40 -0700 (PDT)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] uprobes: remove unneeded condition
Date: Fri,  6 Sep 2024 15:18:25 +0500
Message-Id: <20240906101825.177490-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The area cannot be NULL as we are getting it through container_of().
Hence there is no need to check its validity. Remove the if condition
and return statement.

Fixes: c67907222c56 ("uprobes: use vm_special_mapping close() functionality")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 kernel/events/uprobes.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 778f1978538ce..9f864504a7e92 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1474,9 +1474,6 @@ static void uprobe_clear_state(const struct vm_special_mapping *sm, struct vm_ar
 	delayed_uprobe_remove(NULL, vma->vm_mm);
 	mutex_unlock(&delayed_uprobe_lock);
 
-	if (!area)
-		return;
-
 	put_page(area->pages[0]);
 	kfree(area->bitmap);
 	kfree(area);
-- 
2.39.2

