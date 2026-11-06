Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793949135;
	b=wOreCDfR7+5lJwy3F0tstH6sWuAONIp/3nh3W9huEflqqo8u4rzT5OjweMihlecmTBh/
	 4IGGqTv55RVz5bD5pkr8+mPbTjIJxGmatsgyajRzImZKGwK6gxYETdKRI0avhWOgeiheK
	 UASfXUSSx0HxqtV3SSnHIfT1cRVcF2PhzgtdFu/4XWs8dCDMQECvzAXyc72u+UdfzCsmd
	 zaTWu97CSzYPqmUWYDcVtf4j3UEfO7WiJHgPZsPJpNkP4WwXCDxcUEy/DoBwQpgOvT6IA
	 qlx36gWon1hbQzSscC/LA51sgbaD6v/GEb68WGb6Gy082AhJLO5JnSs3ZGZjNrwbMUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949135;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=2tr7RAK1Z1e7MRIJGh8p+CCxNaKqEt5LEou42TFWdC0=;
	b=fdhfGYs05Oke8FdyBfYwy09Ascd97kfad6WWodIKmNb/UuuqSsBkR5DDwuZLDiCAH5jo
	 TFqkfHlUFePhxNZC+nYby2Ux8AgOB2QTjrdTCJ2uhvqYjdL8mkNJqT7LC3UD5R1yMYbH/
	 hjGwGWybqCNLjoJ6OttQA3DH3jpD2ujYPxYYXmrGnJ5Mtg5LXzbXIbdub1XgOtsJvJeZc
	 /vqK0aZBt7lLPQSfGPsY8rCPi6FUCIZW0dmxFuE457ZNhvhJXu/SDqW+4rylb/I6jFuXD
	 9K88AtOPa78wCgU9jmHdYI5dreMUfxhKcd04Tq6Dod28gve9XD9S2soTAqTxAHKDtGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=95.215.58.181
Received: from mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED82606A331
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 07:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6ED82606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux-perf-users@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2tr7RAK1Z1e7MRIJGh8p+CCxNaKqEt5LEou42TFWdC0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793949131; v=1; x=1794553931;
 b=hUWosO7VT/rCOyObOqACqZsQEy19bkG1P26xbOjYFvsoQbtiwvyMiwrnRjaYlwh2wYqYwpjv
 JV3qhCrQks7lpYRfunnGdRIINQ495SS2MPPRiaWzoE+0ql6RTPU1MCiu8zryk/gZqLRS6y3XZJw
 Uv4Ngz0djRsmju7g3j2Zqqw0=
X-Envelope-To: linux-perf-users@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 007461dbe1b04954;
	Fri, 06 Nov 2026 07:12:09 +0000
X-Mizu-Trace-ID: 007461dbe1b04954
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
Subject: Re: [PATCH 11/13] uprobes: convert VMA flag tests to use vma_flags_t
Date: Fri,  6 Nov 2026 15:12:00 +0800
Message-ID: <20261106071200.52897-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261105-late-2026-vma-flags-v1-11-0d3cd15ab75f@kernel.org>
References: <20261105-late-2026-vma-flags-v1-11-0d3cd15ab75f@kernel.org>
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


On Thu, Nov 05, 2026 at 09:31:02PM +0000, Lorenzo Stoakes (ARM) wrote:
>Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
>uprobes VMA validity checks.
>
>No functional change intended.
>
>Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>---

Reviewed-by: Lance Yang <lance.yang@linux.dev>
