Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B04C49B219
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 19:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789415867; cv=pass; b=P8lAYbCLDFbJIlGTAtu59AAcYgVgEMWycx+BmW1GT5z2wFWcjIfNMmT8cD0unE0cB4cSjZKZKzRBDLaJREt67tRd1ytyJW45JZOZptuQBrbaEFMtihyfl83gdfLWhV0QPCdYu/mnwZoe29Rm32eGBHvM0KBAxWUT6gpOw7C4Vm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789415867; c=relaxed/simple;
	bh=rm+zdLu0LlzNfMP/vZrBYvi966p9ISS8d4XEb3JQ094=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hCI4CD4SO8Cx85Hp0sGrYCOEAnG7eH+CYVM/eD7+SvtVHHbOF/jmokU3pC5wrjkb0Rov3nvtg95WLOvZ/Bd0H9KP/l6QsUA9G+ExHHeAVlJ4hu6cQbNpnm7I3HfMqqaBu20vYdiflKalJVrJThjgKxnJk2Cs5R7C9eYKUQx4EpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VBYIS+ru; arc=pass smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VBYIS+ru"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469e25400so1944925b3a.0
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 12:57:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789415862; cv=none;
        d=google.com; s=arc-20260327;
        b=TM9w5+JMln5YrfbNvhCaLU/6pkOUUpAU9QJKKG92FBAbbTn1EabNfGHrFFFGtF4Qmp
         C66DPVC3aMI1o+Eku1dpedoL8KuGxOjbtqHuzseIJmejDiiyxekaIU+AMy/NLw9O0xCc
         UJk0CO8zUBrpY7EiBRIDrwDUxZZhbhIarPRycKC1TLNYxTX7AwbK9VaCPTzd0iGBHJrk
         DaDkRybX5XjCcGa8UxfesH4tJOS7a1wirJy0cqhgycw3dIcu6tO9JWGUp95FQzVXUErn
         0o5rxCXwUtSJWcyFyymPtPvtT+oFrKmuKmEPNtnfJKNdQ6tL1s6nM5SRBRa4xTZlK/Qr
         AtDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iEa5EIpxI31VfZhRCWTdUVuFxMmPcLfnD5/j1cH2Le4=;
        fh=BwgwLGzx5XhDvg1zzmxaFMFk0qa0brUNSe+ulrxPqzg=;
        b=Q/HjO6C9AIs8H+YhIcHwrBR4e5QLJ1A3Dk75ob21mNamoMcn4CXHWPoWSUpv2mzqe2
         acBBaOwginfsXIDGcIPDdZwGNrlQQRB4bg3y80snf7oT8xn5Or4lIZvEZcwNWjIR2TGH
         CfDhe7NxSHBrIIlwKrWeCprqTEBITJcK4J2G0YguZvYmcCX+q4U12h0ujouqVqfnISq/
         nQby4gCXV8c59NNiNMKs2iWAuCJo+6gIz3r4E8Yz2ojppAXIKz2WhELtsZ/+Boug9tDX
         dsYsJV+aY3UG3gpgb8fwtg48VmAAANHHpfq+ZC8KgioN+w9OcVQlR3wAlpnYIalIruTi
         CAXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789415862; x=1790020662; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iEa5EIpxI31VfZhRCWTdUVuFxMmPcLfnD5/j1cH2Le4=;
        b=VBYIS+ruvec/YQ7NPDSavrBqZkup3jtMUSf2x9fg2vR4Q/ZYGnptCqM7UF9GBEk6Kb
         pwYbAK2sJEZFDjRFht2ALhGnWfzEgxLd1W4Nqjf3iOyc3C9CQVwNzR9p52/m8eg00t3y
         i3INHp65zySvAJlrkN0SKQiamBOPK/2OeoXHbM/ieIzmZObIDK9PzOChSRrcM8YAyS56
         Wpk2JsgEsfietAppzsrHDi7c7Qi8vepD85wgaha++Drvrzfs42k7ryFVO4ohzIir1SFu
         Dz5Af79neP1/ODat12UTHwq79Ug1vrjKu97+aj6V0fudJlIrOVtfB5xkOELTreMhvqOw
         VVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789415862; x=1790020662;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iEa5EIpxI31VfZhRCWTdUVuFxMmPcLfnD5/j1cH2Le4=;
        b=kiZCjPDX8+9kCPCyKk0Yt/QNxbDUkkNKlJgtQNH0Lg6pZwx9fmT8m3R3MWzG72b1Oi
         Ylnor85a7e6p5hw9grtQkEov0Kxz5wAms80RQmIvxWe5ZEyLGAifu8csDybz7FYzgn68
         8B7mJwFikNJ1srYTN9e6j6PFSZwDuDQvg7CLeqJUwlmcnDDjdGi+QrEiJ57w8yR2w+R6
         jCqVzlb7iX67jlSTOkPNEDGspoat2+YzL6GjrqvMy3ze7O6MG/Jh/jZCeX5OELObc5+y
         NN3FIAnswPOY5YKa3s9bHl6OAIt0k3Lp6897A9dnxb/oDMgLReA7eH3hiWK4w6LOrXFh
         eJng==
X-Forwarded-Encrypted: i=1; AKwUvBx9mcVKRc5TMwuxielhdTYrvFh4IdeYr7U4LzDTMJXtjis4ly4f8WdmsLVu53d3Zm6zZ5VLzMgIoKG6iZKINm1o@vger.kernel.org
X-Gm-Message-State: AFuF++k/UfvAcsS9VGMyRQC2sKpHEDCqTZ93WxAA6eEsz1rCVwRushwn
	I94NbKRncygQCmdGprhV+GTER4srUL8KWsrVCfM8xkm0njVoOZoh4JaeTYl4x6r50+7BPHCkv1n
	STWOqiE4qUeparuaUwA9+YUJBSKo6Zeibc4sicjKq
X-Gm-Gg: AYBFou2ua/uzCAFhStv2ghIKPXNtLBOFmGvzwI3WYnPn0WE3Riqm4drSR/AMR3hl7m9
	Onc9H8FJZJbHcnejDM3sfd3oL8vTqHwNi0XqDXmdjqFq9+8gVARy83roNCR2tPFEX3bPQvFPXTH
	g9A0uMpi4lnfKQTl8RuZufjEpq58kuWmayfBJ/Twn4H5o6axT7gIkj0RfzkpO4OAlzxfmsRvMKt
	w7+XjZ6B0mwXO6oWew8mH6lKDA0GSdUx+Sp6Nr1XZ4YBH46OOSUaksFEn7eCFg0S7R6fATEMO0I
	0aEK9+u/C0o8FHWaA1NOJ7ho5ago5AXlrlp/oveHDBhtKj3tK4n+GSFRzNsvDxMulnBUpq4s/RH
	p2Hqp3IEU9AQ=
X-Received: by 2002:a05:6a00:18a9:b0:858:b809:6ec0 with SMTP id
 d2e1a72fcca58-86f869a920dmr8896742b3a.23.1789415862342; Mon, 14 Sep 2026
 12:57:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org>
 <20260914-b4-mmap-prepare-vma-flag-sanify-v2-12-7d9781ed5361@kernel.org>
In-Reply-To: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-12-7d9781ed5361@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 14 Sep 2026 15:57:29 -0400
X-Gm-Features: AcwNN1XaLRK0KaZAmfcRvdaBSkZOdh14LF1fb-xWULoFVhBfqyRklsdKoWBmLag
Message-ID: <CAHC9VhQ3TwdGGH6YtVyMqJX4avJwsadcRvRhAoUhCvJEHk=i=g@mail.gmail.com>
Subject: Re: [PATCH v2 12/40] selinux: reject writable opens of policy file,
 drop mmap shared/write check
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Doug Gilbert <dgilbert@interlog.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, Jaya Kumar <jayalk@intworks.biz>, Simona Vetter <simona@ffwll.ch>, 
	Helge Deller <deller@gmx.de>, Sebastian Reichel <sre@kernel.org>, John Hubbard <jhubbard@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <baoquan.he@linux.dev>, Youngjun Park <youngjun.park@lge.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Xu Xin <xu.xin@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-rdma@vger.kernel.org, 
	selinux@vger.kernel.org, linux-sound@vger.kernel.org, bpf@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 11:05=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.=
org> wrote:
>
> The policy file has no write method and is exposed read-only (S_IRUGO in
> selinux_files[]), yet sel_open_policy() performs no open mode check, so a
> CAP_DAC_OVERRIDE caller can open it O_RDWR. Reject FMODE_WRITE at open, a=
s
> kernfs does.
>
> The file can then never be mapped with FMODE_WRITE, so do_mmap() always
> clears VM_MAYWRITE and VM_SHARED for MAP_SHARED mappings and the VM_SHARE=
D
> check in sel_mmap_policy() cannot be reached. Remove it.
>
> This also stops sel_mmap_policy() clearing VM_MAYWRITE on a mapping that =
is
> neither a PFN map nor a mixed map, ahead of the core enforcing that only
> such mappings may do so.
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Reviewed-by: Jann Horn <jannh@google.com>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  security/selinux/selinuxfs.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
