Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.242
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793951164;
	b=OhrWL1iE4ykrfADWR1BcNHq2+5OkUBwqmIvlyU+HVS3kKwh0aAEYPYXl1LNXkRvmNAP9
	 h09pX/lKsMObSIuFwzWMZEeAyZZ9ES9FTs3ORURx2arVrtVDmh8CMr4JLN9kUu6qwmP0g
	 V0AtOxMoXQ+9eAQX45ijV3f9be8Z6x1GsOoz4xWgIBFfAoOPomkFIdFbXUQDEvYfCOixE
	 6pKcnoOz7BaXfQhGne41VGvQgVWf9rhHXgnMTYYnS6++74Ir2QNWK+IxxbKwQpcJee3aV
	 eEsRX2cyaAmEnsmWNnbtXfOsU73GCiMmlrEVN17NQeFV4atFbNH6FmDFbvsusR3xuYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793951164;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=8RPjRkRw6TGzo85+j1RMaJO9Gz+t0O/3LiAQ/KX/BlA=;
	b=TzhTMtjxlWE58ASFhyQMlUByv0bjhoX5gH/Xv41rkrdS7ldesoQw97e5w8aUHVwS8xuN
	 41RPgr7JwtnsRZjuxbVKrXOz40zLdSoh3K0gb29fMJJOawp/ddNVe3BLr/M1qTLAfPVj6
	 o2zgM3FMUHzyrQk+qaTQa4kazWasy5JcmhJpT1L/7LsI7yq/69+EAaIg5H3hD3tWKCA34
	 +GPxg3JXSH00ViriP60dIBC0/6WdX6MgnidSpZb/Qh1seKlyq/G/PZs34S06wB9LAAbdF
	 7+8ex4CidO/C3NO0HytkcOEpPfoe4L5eduO+tOtIGZSQCQm4hqu+drFi7YFVkoeFEFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CAE0qa+5;
	arc=none smtp.remote-ip=95.215.58.242
Received: from mta1.migadu.com (out-242.mta1.migadu.com [95.215.58.242])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09F2606A331
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 07:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E09F2606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CAE0qa+5
X-Envelope-To: linux-perf-users@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=8RPjRkRw6TGzo85+j1RMaJO9Gz+t0O/3LiAQ/KX/BlA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793951162; v=1; x=1794555962;
 b=CAE0qa+5374oj+hHwWnm2W5IaevfinVazBMemgP1ISzO8J844t+ZYUXtmKNVpElOLzh15dx/
 pG5kfDcjIHPhdpitiYL/MHak/QGtgYjDqI93gpNCUB3X03PFTIvTz1Lxi2Kks2ZrpZGmLEkufLF
 ZZCbEb2cR6TWAUeWwMlUidK8=
X-Envelope-To: linux-perf-users@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a2e578c5cb1dba6c;
	Fri, 06 Nov 2026 07:45:25 +0000
X-Mizu-Trace-ID: a2e578c5cb1dba6c
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
Subject: Re: [PATCH 12/13] perf: convert VMA flag tests to use vma_flags_t
Date: Fri,  6 Nov 2026 15:45:19 +0800
Message-ID: <20261106074519.54904-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261105-late-2026-vma-flags-v1-12-0d3cd15ab75f@kernel.org>
References: <20261105-late-2026-vma-flags-v1-12-0d3cd15ab75f@kernel.org>
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


On Thu, Nov 05, 2026 at 09:31:03PM +0000, Lorenzo Stoakes (ARM) wrote:
>Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
>perf mmap and mmap event logic.
>
>No functional change intended.
>
>Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>---

Reviewed-by: Lance Yang <lance.yang@linux.dev>
