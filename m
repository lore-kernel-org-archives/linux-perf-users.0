Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793947249;
	b=ZV95WeG0PpcJD7m1gfAb+TJQTC3coKXBPqqb6Yoc+El/C93bHMM1Hn0QtJr+wMavvrjk
	 2Wl0HRiUzbFRe2x4rNeb0pnmwPYx/G45432Ryl4OieNH0u0Yf3ItNiQSm/qnCAWfmN4H9
	 n2II369iAvn6WCeJm0zHBFL4YB5yNdaJzBo9OrHJ3kBRcb4jl+UFwDdbpHHb+LwXDSFEU
	 4jEi0w/xRiBPdu0h7wlR2FSJ0pu4U3Zm8KpnNhTFwN/25N5CXzN2MaS9rhKmrLZ0McOwY
	 maP2WFmdwPLa+7gX8va6rq+/Sr4ESnBBb9V4cdl4aeIWQ3nCu5hCSoK//kJWAPH8Ksg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793947249;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=/4USJW9qcyUNn/FtQy4xUl++EAECigPJpoER1jiXivk=;
	b=WIIpulNoEBfIL5T92o+tIMRXlzJ5S2JJPKk3jxI1jPckqSqnU2PFiAGgXJKhJ7+RvKWG
	 SOBamNK6WHRP/KE9DAWjCqbCU554UWcOyXm7lmBHXxvgqOIZ/14OYVdk0ata4UdVnbuoe
	 WNBBk7BVv46Z/sg1gGuKA7P4OptdUqqw+WourtiCirI9BOgQD3fjMfX3vOqcaJEDzSDO3
	 7zp5s0RwmSH/po5sl9HwYrw/BD11q1bpWgH3tSN4Q3CfRht2A8v2n89aQ1QIzAEFm9YfT
	 5LemasLonnj75bBRTBLSkj6u4WjXcfBKpxZ7A2SP5VB8V9r0TxLReAxj9v66GpEwltg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=IcbILbbr;
	arc=none smtp.remote-ip=91.218.175.144
Received: from mta0.migadu.com (out-144.mta0.migadu.com [91.218.175.144])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3445606A32C
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 06:40:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3445606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=IcbILbbr
X-Envelope-To: linux-perf-users@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/4USJW9qcyUNn/FtQy4xUl++EAECigPJpoER1jiXivk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793947245; v=1; x=1794552045;
 b=IcbILbbryd1I3w1iL8fhJLF2OUYHv5Tyqkc68QQjOHZymCkhfCKDjFPt8t5LirvIlRN47tqe
 ee8LhFrRGDFMoSWHsHZ1JFPRE1zEzqKvRbBoUIV3cCuFStEPm2EHHYMP8JIUF+xhi6tgbXWaNEp
 SgWZgo+3zPwEUJKaCwLHEWp8=
X-Envelope-To: linux-perf-users@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 500c6a5405d2c587;
	Fri, 06 Nov 2026 06:40:42 +0000
X-Mizu-Trace-ID: 500c6a5405d2c587
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: ljs@kernel.org
Cc: akpm@linux-foundation.org,
	david@kernel.org,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	willy@infradead.org,
	jack@suse.cz,
	riel@surriel.com,
	liam@infradead.org,
	vbabka@kernel.org,
	harry@kernel.org,
	jannh@google.com,
	lance.yang@linux.dev,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	baolin.wang@linux.alibaba.com,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	usama.arif@linux.dev,
	kas@kernel.org,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	maddy@linux.ibm.com,
	npiggin@gmail.com,
	mpe@ellerman.id.au,
	chleroy@kernel.org,
	ritesh.list@gmail.com,
	sshegde@linux.ibm.com,
	pfalcato@suse.de,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	leon@kernel.org,
	sj@kernel.org,
	rakie.kim@sk.com,
	rientjes@google.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	mhiramat@kernel.org,
	oleg@redhat.com,
	john.johansen@canonical.com,
	georgia.garcia@canonical.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	wufan@kernel.org,
	stephen.smalley.work@gmail.com,
	omosnacek@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	damon@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Subject: Re: [PATCH 08/13] mm: convert miscellaneous VMA flag tests to use vma_flags_t
Date: Fri,  6 Nov 2026 14:40:36 +0800
Message-ID: <20261106064036.47774-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261105-late-2026-vma-flags-v1-8-0d3cd15ab75f@kernel.org>
References: <20261105-late-2026-vma-flags-v1-8-0d3cd15ab75f@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Thu, Nov 05, 2026 at 09:30:59PM +0000, Lorenzo Stoakes (ARM) wrote:
>Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
>remaining straightforward VMA flag tests scattered throughout core mm, HMM
>(and its test module), DAMON and the OOM reaper.
>
>No functional change intended.
>
>Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>---

Reviewed-by: Lance Yang <lance.yang@linux.dev>
