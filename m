Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5C4477E34;
	Thu, 30 Jul 2026 23:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785454474; cv=none; b=XcPmXJGGQgvVGOuBzky/EO534qpgrUq6A4+JTSXuikhbaN0pM03yWv5Y49/7CRX2i3kayX/MmeywVmrlvbVyrlg8+XRnvJXssokwjGe60Heizi+2Ntheb9yEj8ZC0jS8GM1QZSjPlTo20fBendv/mQzZVmaxfvovKnqfOg2SlPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785454474; c=relaxed/simple;
	bh=Zoih0WN4T/DOF/i8O2XCU4gbO3+Agq/lai4Rj0wssSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Da6s5foy0nuW0TZoWcA49NrViAGh9A4ASTCoqMd+OB7wpUn2PRiQJSlbEoplJqnUtX7coP5/Ro8d7DAXVrDZmfRybow1tCyIiUbrm5tTAh5Eq9TldkdGHfqixVzuG4aJeGWCqF2nPokkYmYM1HKMFodAOCP1dOHBqdjOlbN/PX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GROTxNIu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GROTxNIu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=kgKxOGe6An5qA8u/krBtgevrWMzEhnZhr2WUue9qySU=; b=GROTxNIuT/cBeWq86lswkJwZuq
	es96pE9e23oTbjyIUamDdy7XcmMpjBxUP0QWtZbfAQn/UbZsrDtG1r77yVF71lY5bGAt46anOICni
	wyX6qV1YVV49F83lp+YujkzK0LmDunMY9ZRD2zb0N0VrtyY6odPKqc1hFzsYea8mBTLWXCSMr/DeQ
	hKrhr3m9nuZ9pLyvDSNbahlW2IXnPFFnLR+sKSiGvUtuijV9H/DHAJw9u7/xKov8KsgyoCWp8fBiK
	2XInHF9ckfqauj/uV8MG1jQrCaW0RN8OitMNIhhiGMny+Ohg+xYf9sMW44CqrRasLiYaD67N6TtT/
	7FbhO+Ow==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpaGk-0000000BViq-3seT;
	Thu, 30 Jul 2026 23:34:30 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/5] perf/x86/intel/pt: drop kernel-doc for deleted struct members
Date: Thu, 30 Jul 2026 16:34:25 -0700
Message-ID: <20260730233429.285788-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730233429.285788-1-rdunlap@infradead.org>
References: <20260730233429.285788-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

@lost and @topa_index are no longer part of struct pt_buffer so
delete their comment lines.

Warning: ../arch/x86/events/intel/pt.h:86 Excess struct member 'lost'
 description in 'pt_buffer'
Warning: ../arch/x86/events/intel/pt.h:86 Excess struct member
 'topa_index' description in 'pt_buffer'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
New patch.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: linux-perf-users@vger.kernel.org


 arch/x86/events/intel/pt.h |    2 --
 1 file changed, 2 deletions(-)

--- linux-next-20260722.orig/arch/x86/events/intel/pt.h
+++ linux-next-20260722/arch/x86/events/intel/pt.h
@@ -58,7 +58,6 @@ struct pt_pmu {
  * @cur_idx:	current output region's index within @cur table
  * @output_off:	offset within the current output region
  * @data_size:	running total of the amount of data in this buffer
- * @lost:	if data was lost/truncated
  * @head:	logical write offset inside the buffer
  * @snapshot:	if this is for a snapshot/overwrite counter
  * @single:	use Single Range Output instead of ToPA
@@ -68,7 +67,6 @@ struct pt_pmu {
  * @stop_te:	STOP topa entry pointer
  * @intr_te:	INT topa entry pointer
  * @data_pages:	array of pages from perf
- * @topa_index:	table of topa entries indexed by page offset
  */
 struct pt_buffer {
 	struct list_head	tables;
