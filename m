Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794461790;
	b=gzPniucnApb5NSRkrC/Yhpe1qQcdm//ziAVbQvl2Kt36Z5LAiMQffbWfrNLT1Fc1aK8y
	 XqscztRJBw2IwJQGwHTGzwvJJM6xWY1Sj25P1SxNehUbKlPckuEnY00b/Au7UcJcC2FIB
	 l5PNnU8bAJMuglkVHOF+sF9ikAg7sdUb30fdV2c+cGdFqframpomV5zHg13dCSMOjbIOj
	 08By3BSTYzAmqT2QlyDk6OFeKvxDMiFv2Uh1cq99YyEIY7v5O+fAt8S/OuxCAPd+xjZPX
	 X4YRrDNPRynY/I4/2brzmyjfsRkUAmtJQcWRZ/5dY7OHAJ1TO+IMrcYzbzq9RVf9wrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794461790;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=e2soeXJ852281gC+OC2yZSX9G2s4v3lG9pbKt+VP0DM=;
	b=bFXVgaVnukBuGDlnXdffIeBXRqbUnhLlACflJBcJ8swhbEBvKB1O4Yq/dnKJqOeTPsZ+
	 Z/7L6lVL65BzpEVaCIvcYsRwyVOav4pj8Kp/+W+FE3JxC8svFZxuzKFxc+WNNyhfjAzYj
	 ZlQGqYJsn+7S9h9MgVE+NiLIdEfPfNtQuyskc8KEHhYQTrsw6I8MXprtqXSBSXt2Ndoqh
	 kJSjjueQPsc1Mumv7P0jCaHdKjpJzGX/woe9lEscSMmHWesDUvZ1ZDq1Gm1krVm9rtBxR
	 j1s9GFPJRyRuR15KsEH+uxAyw8/FeCB16wVGYhFBmR4VAMc8yac9FTLyiYFDf331ADQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=EzLeINlq;
	arc=none smtp.remote-ip=209.85.222.177
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428FA606A33D
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 05:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 428FA606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=EzLeINlq
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93e6eb77f0bso350310385a.3
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 21:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794461788; x=1795066588; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=e2soeXJ852281gC+OC2yZSX9G2s4v3lG9pbKt+VP0DM=;
        b=EzLeINlqWKLSrVyAYeG69cub/PpkhXEpvLI85c2/Wn4DBrX36De6eOjOc825yh2/s8
         /BMocYYbFGCIGlSENImF1edskqevAV/Kuf1SeaFnM5vAAp8DG8IO1FgayCsUEWs73OHL
         1RmURtZJc9D4dd17Nf7TyLA18R4yata5cpiLNB4SZ3wXp+wb6mfksV9V6NYOJLevPnzx
         KS0lFdrtd+eUvcxCI5cIGAuAdA3+x/lK/g0n6XOLpuLtAwXE7FSdI5GYz16DwRhEZcI+
         e0xi/xTmcXSNKhZMTs2dmsnafffo4Jcsb0EhR1rdi49ZUTTTqLCosCyqFBij3UK+VNvA
         tckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794461788; x=1795066588;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e2soeXJ852281gC+OC2yZSX9G2s4v3lG9pbKt+VP0DM=;
        b=If1iTRDfoUk1o5Oqr6pYnpSU/DK6GcLuyHN//0NdhnIX1mHxQVG+Of/RMKJ1QdRfba
         8onuy3cdX4hb+CVd+/48oLJo4wsMyJIoiMUA5dBbJwD8BY13Rx+88+xLIG50F6DGsPqV
         64jv+DuyfEERbRFFN7wMBU670xUfCo0B/KyazwlH1gzTQqqE0zJe2wkplPrD6zzx9HHX
         SFix8Kr4fCvj4xBOWAcWxiM1W8Y6QcdYhryIfCwTrV+YOYaEEUYMkxQF0sNhYss8rrFo
         aOY9CdlD42iZY8C+OsYz3ZN22SyP76djioC2BWGpGamDzFw0rFcHBhUgnRISQLTxKKid
         xKSQ==
X-Forwarded-Encrypted: i=1; AL+hErFOwDyidMEgnXtqfrPPsfp72JrvUMB43CkS4qpjlHCHQejM/Xz8k9IpzaOmGWrH6XscHb6+k4XfxagVmPNLxSUd@vger.kernel.org
X-Gm-Message-State: APuU4Z/NtELwsadQ0fQRQUxhQW5wrLpFqqiMhGeLbe0Bn+RfIIrYQC9x
	lJL5SOm8mrYpCw/fr/bK4um5vT9Flw4NHaWNGRFX6v2vTSCYTICeFhB3IKlu1/czP68=
X-Gm-Gg: AYBFou1bVrFdW4IGoM5sYdIyEIdfzGT8Z1zpwCftskJXnyT8Je7AkLKljRPYTQ3UjE/
	7ETevl/4vt7wUxoSWkHHOzcK3kuDlaV7G99KPyQ2G4WOgsXve4CNNi3INZD2Uyc+MRWJP7lq6kI
	0NnAoLZyN9i82j8cQGlZt2zJ9ZIRqsS7z3r4oraJuaT5ZtFWS2WTmoGgfLLo1hQxWfXLE3PbSLS
	9b6aI+prK3+S/+i3dgIkxB8M2Diiyk9xTnd+2ylR5C340zQ4XfVVmnZeI0b79rtXfKmt2kRK1bj
	fapfSVf+ZNlPGgbZVErqx98ztLbVJ6pXWme1Jt5Mv4EQhoKI3F00NnyuTH3vHXGgEEUmMKjIEEN
	aFDbg0L3xQ4bsAHRUZ4JGZUrU2N41VlYSpBKUX0imVOqA0enSySmpc1k3PaFelG6xfbse6NtxQ8
	3hp6tWXy8J4IbAYStMtLkMYt3F/nooOrlHMfnc8etwtAZQgVtfwEGjwGipOzNixRRoJ8uHS44VQ
	Rl8INZOtefMCkF8TOdR+OeylyB/J/8BNf3fUm7/6XL6NWXHaZRNzKz1TOXrTJhQ+b0jeFUtKPxB
	9u51tb5a5QitOOMypFgpMoCdBIzCabWKsr0ErCjLReURldWZd5U6ETlEYLfer5T7LJyyYmNf9fW
	hKwxorlw=
X-Received: by 2002:a05:620a:4481:b0:93c:c2c2:40eb with SMTP id af79cd13be357-947b0046fb4mr764496385a.66.1794461787830;
        Wed, 11 Nov 2026 21:36:27 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e4fa312sm647786285a.0.2026.11.11.21.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 21:36:27 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 08/13] mm: convert miscellaneous VMA flag tests to use
 vma_flags_t
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Rik van Riel <riel@surriel.com>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
 Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>, 
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, Pedro Falcato <pfalcato@suse.de>, 
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Leon Romanovsky <leon@kernel.org>, 
 SJ Park <sj@kernel.org>, Rakie Kim <rakie.kim@sk.com>, 
 David Rientjes <rientjes@google.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 John Johansen <john.johansen@canonical.com>, 
 Georgia Garcia <georgia.garcia@canonical.com>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 =?utf-8?q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 kvm@vger.kernel.org, damon@lists.linux.dev, 
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261105-late-2026-vma-flags-v1-8-0d3cd15ab75f@kernel.org>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
 <20261105-late-2026-vma-flags-v1-8-0d3cd15ab75f@kernel.org>
Date: Thu, 12 Nov 2026 00:36:24 -0500
Message-Id: <179446178440.482102.12362401790016415292.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-05 21:30 +0000, Lorenzo Stoakes (ARM) wrote:
> Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
> remaining straightforward VMA flag tests scattered throughout core mm, HMM
> (and its test module), DAMON and the OOM reaper.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Acked-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

