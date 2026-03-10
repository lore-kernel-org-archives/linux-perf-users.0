Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BD240DFCF
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Mar 2026 13:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773149103; cv=pass; b=EhA2uS+XB5M1vzPm+LdZBENlMGh6SGFazmXZYPTPIPPUfSzVoCfXwlBOvx8gPVMHbIbn5IqhU8dgeym/jQR3Z9qZYRJaHygbDd0+RxE1lCWrHaVN+kCe9rISzbAHxZ4XKBJRqrnUkt/OtByJHjyr2TH42H+PItBB4ULxHmFZ5ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773149103; c=relaxed/simple;
	bh=0J1oU1eZ/G2C8shiXa/TV85nKwqsp7/o9q6W7EIdKMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EVdSslRfs5OZkr58zzSaDGfXx5g9r8E3BmZkm0K/9vs6Mn+qFbuZPeZFzUo2HgYIA545kh5jIjqSOK8Ajz59+ll14FksHivtcBXMP9UTlYFhSh/K2mQv446NlIVmZG/9uH0uKojNeTV38nhg34IkNia8e74INO3C1sijBJtPIJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YsC1uHQS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=uOa00rIr; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YsC1uHQS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="uOa00rIr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773149101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+mRiZHd3hjy9wYbcMzg1z2YcvSrUrPgvmFfUtqm16Gs=;
	b=YsC1uHQSycanBy/TpWW114jdVzDx2tLzkVG/JfhfhFVfkQVkp5E15VVEvdmWtkHghsMytS
	EKclehxdSJnFRPi79Ud9e9WV0mXOSAJpxmoETxTrV7yjknud8ROBp26SbwiItUCdzXTIeC
	+oL4dxX73xbcc2M6N06xwiLpNOxhsEI=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-nWBwTRd0NWOtTtTQ3RX9Gg-1; Tue, 10 Mar 2026 09:25:00 -0400
X-MC-Unique: nWBwTRd0NWOtTtTQ3RX9Gg-1
X-Mimecast-MFC-AGG-ID: nWBwTRd0NWOtTtTQ3RX9Gg_1773149099
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-67bc3417e12so2067593eaf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Mar 2026 06:25:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773149099; cv=none;
        d=google.com; s=arc-20240605;
        b=V6v76emR7LNF1ip0RoJRYkEbyRhvEx3QutHwNDgQIgklKhBreNuVzakybb8aPFLY8F
         3/1N4t12p7gTfjxrV7JJQQfPkcaCPD8/LWNneu9zhRnfl8zCZApwtYD5C9MfiuuBM6F7
         8Wmd3cVYMxZ4px71MQg5baFtcd4ACvdnK0Wvi90gBYILYVs+E/EVzcWngANCPlPmwHGt
         yN2sl2iXrtymH03p54oGiQu2mUw5O4Bw8AqoHj4c4TgQ0qT/dVJLSyKMV4r8fPEwbXzl
         uRBlmr1bDwGACjPoK5RtKzAtb4YPx8MN5TbSZuUIkUr2NqjsDgMuLzdSlRqrO1AkqvRl
         oYyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+mRiZHd3hjy9wYbcMzg1z2YcvSrUrPgvmFfUtqm16Gs=;
        fh=FV59tNSMbT1hfeOkYFr9bDmiffmJbKAaDzQYMvAZIsA=;
        b=ZHMidba2faN4x9OJHrACfHSyWyOPCLdLAZo5cYqBqZa+w33R5yMAy93l+PrK8B0q2k
         cIZbiS1v3ojkzRBgX8GNS4xqgFyKKhk2I5OtDNCgLLcwMf9UVqb0eLYOBSBC7ugCE/go
         DLMZNsmQoA4+ktdFy5qf76cdvFy34T8eo/FCMruZJRfjr5DNG9Lf7qNYgqCPsUAgF0o8
         yeqQ45vlHp++XJvhcv35K/1HYxtJbPVGgrgvpyBGWISo3wPu0fOcaWnHCG99bHaHgChT
         AqArzX6UjBz2h1EjK1OFtiqbLYln1soN6ZpIhrPnMpr8vdbJvfqxYz2REJ9kd2fLLDSu
         0jbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773149099; x=1773753899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mRiZHd3hjy9wYbcMzg1z2YcvSrUrPgvmFfUtqm16Gs=;
        b=uOa00rIrG1AcXdriAvon/+RLwTKEDCNGIzIqDlUN5LW7kRgmcWH3c/kcxnXLF6kKq/
         x4Ase1h+tPCvwSsKYC18+v9Cj0exn0uAjA4S0DTsq8kXBcmMTPpSBQ2DpckP66FtFm2v
         U86jyOgsJQzNK8ANYlYBfCVYwTodDQYDKLr0cS3OiPnUfBs5QrjLzSU88D3rLc37rsMj
         7XbM1rFjhtZe9NDZfbyOM+vKUzX5lqtJJUExiR0vZToaBa4ovt2jEb9CIJWdG0T3LqES
         v8dFolYbOo8OZxKAkWVrsMOP0OMbQnv2B+jdOriMxIHfV4/JSK+uxHBaZjQxtaD2qh0u
         wzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773149099; x=1773753899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+mRiZHd3hjy9wYbcMzg1z2YcvSrUrPgvmFfUtqm16Gs=;
        b=S653u+wDCbBxgB/frfTR60QmndnnfJFEy/kXmPRNrRmBpFCYh9SuB4UDcC0RnTDJn0
         k/3AzHbxqsHOkJ7+kUHA0kHPHXzfhQhHuaaMahQEM2hHZZb1ClncE97TYwG7hXpZI3AY
         V1dS9Vli5xDqFLD7lQwUQn04YyPSJeeRDyDWvV8COqAkaoQgh2wShFdyA57VCBglnLJ1
         X3qP7pcEwoWz3mU6Z5JGcOiMFs+vL1CTtnkjhNJWpcEfDTxVeNFOTaZuJydUGuy15nAL
         TfTw3I/+DC0mbSYBfMlRdhA4BeT9TJc+h+VgOF6a64Ngddacsh/n3vZ7X2nsVNMs9L1O
         9ysg==
X-Forwarded-Encrypted: i=1; AJvYcCU/velfudfDxlCbOPCBZ4y1wyIm3HB7czGBGT4kR/1VYVm7zKJeuOTnCffa3GmaF5kd8E2+TNle1t6ktflkdhXm@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj13i3Y0Ysxf/lsG3spqyY4zrl79iL8M0CKImEFIphtTgmZFPm
	1mntRWg2QOaLf+yd4jTTFwPlP37rUlAiXHwoP361U33JAPMGELzTdLPzjPRc0ve0+CasXctvMle
	o0uzNU/JB8snTk/pAsTNsOrA2YDNsNi/HW/DbG5gmftI48nVMouliHL+u/gBmM9HNi/tKWRhVJh
	h7OJ3w2B9HrN8Z8zuw0z9jo8pbRFQPmOhA8jzICe/ebGYwhw==
X-Gm-Gg: ATEYQzwjoVyQV/iC1K+FJ4oQOEOVUKiFzGAQayxHS1WKvrwONo9dOx/XzpeuGQIBMhD
	Fyv1s2hvs1oXedGUszfybKtTunF+s1+j4FGL9ddXkrjp03Igs3zmmvUJsjxW+UFg1pCW4qd90sH
	mMCZxezCD5necZ2Qy18dIPtW0aX421XsF/a+fNmdWpt+SMy3JFqDbcYC+rtWAOjO3yLCK8lCDGM
	Vx0Wh8=
X-Received: by 2002:a05:6820:2188:b0:67b:c08f:c646 with SMTP id 006d021491bc7-67bc08fc867mr800204eaf.45.1773149099364;
        Tue, 10 Mar 2026 06:24:59 -0700 (PDT)
X-Received: by 2002:a05:6820:2188:b0:67b:c08f:c646 with SMTP id
 006d021491bc7-67bc08fc867mr800178eaf.45.1773149098970; Tue, 10 Mar 2026
 06:24:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309144045.169427-1-vmalik@redhat.com>
In-Reply-To: <20260309144045.169427-1-vmalik@redhat.com>
From: Qiao Zhao <qzhao@redhat.com>
Date: Tue, 10 Mar 2026 21:24:47 +0800
X-Gm-Features: AaiRm52us4L_x-yzPwkJaPK73H8lBCzWxkyJHukmqBE4DeWQ1HyAoAtPgAw11Ks
Message-ID: <CAATMXfmc8VAGh3d1D2MYPvZQiUpwua8o7FyRngSw4CmyRPZkrQ@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc, perf: Check that current->mm is alive before
 getting user callchain
To: Viktor Malik <vmalik@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
	Paul Mackerras <paulus@ozlabs.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Saket Kumar Bhaskar <skb99@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Run the BPF profiling program (profile.py from bcc-tools) on a ppc64le
machine and passed.

Tested-by: Qiao Zhao <qzhao@redhat.com>

Thanks,
Qiao

On Mon, Mar 9, 2026 at 10:43=E2=80=AFPM Viktor Malik <vmalik@redhat.com> wr=
ote:
>
> It may happen that mm is already released, which leads to kernel panic.
> This adds the NULL check for current->mm, similarly to 20afc60f892d
> ("x86, perf: Check that current->mm is alive before getting user
> callchain").
>
> I was getting this panic when running a profiling BPF program
> (profile.py from bcc-tools):
>
>     [26215.051935] Kernel attempted to read user page (588) - exploit att=
empt? (uid: 0)
>     [26215.051950] BUG: Kernel NULL pointer dereference on read at 0x0000=
0588
>     [26215.051952] Faulting instruction address: 0xc00000000020fac0
>     [26215.051957] Oops: Kernel access of bad area, sig: 11 [#1]
>     [...]
>     [26215.052049] Call Trace:
>     [26215.052050] [c000000061da6d30] [c00000000020fc10] perf_callchain_u=
ser_64+0x2d0/0x490 (unreliable)
>     [26215.052054] [c000000061da6dc0] [c00000000020f92c] perf_callchain_u=
ser+0x1c/0x30
>     [26215.052057] [c000000061da6de0] [c0000000005ab2a0] get_perf_callcha=
in+0x100/0x360
>     [26215.052063] [c000000061da6e70] [c000000000573bc8] bpf_get_stackid+=
0x88/0xf0
>     [26215.052067] [c000000061da6ea0] [c008000000042258] bpf_prog_16d4ab9=
ab662f669_do_perf_event+0xf8/0x274
>     [...]
>
> In addition, move storing the top-level stack entry to generic
> perf_callchain_user to make sure the top-evel entry is always captured,
> even if current->mm is NULL.
>
> Fixes: 20002ded4d93 ("perf_counter: powerpc: Add callchain support")
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---
> Changes in v2:
> - Move call to perf_callchain_store() for the top-level stack entry to
>   common perf_callchain_user (Saket)
>
>  arch/powerpc/perf/callchain.c    | 5 +++++
>  arch/powerpc/perf/callchain_32.c | 1 -
>  arch/powerpc/perf/callchain_64.c | 1 -
>  3 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.=
c
> index 26aa26482c9a..992cc5c98214 100644
> --- a/arch/powerpc/perf/callchain.c
> +++ b/arch/powerpc/perf/callchain.c
> @@ -103,6 +103,11 @@ perf_callchain_kernel(struct perf_callchain_entry_ct=
x *entry, struct pt_regs *re
>  void
>  perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_re=
gs *regs)
>  {
> +       perf_callchain_store(entry, perf_arch_instruction_pointer(regs));
> +
> +       if (!current->mm)
> +               return;
> +
>         if (!is_32bit_task())
>                 perf_callchain_user_64(entry, regs);
>         else
> diff --git a/arch/powerpc/perf/callchain_32.c b/arch/powerpc/perf/callcha=
in_32.c
> index ddcc2d8aa64a..0de21c5d272c 100644
> --- a/arch/powerpc/perf/callchain_32.c
> +++ b/arch/powerpc/perf/callchain_32.c
> @@ -142,7 +142,6 @@ void perf_callchain_user_32(struct perf_callchain_ent=
ry_ctx *entry,
>         next_ip =3D perf_arch_instruction_pointer(regs);
>         lr =3D regs->link;
>         sp =3D regs->gpr[1];
> -       perf_callchain_store(entry, next_ip);
>
>         while (entry->nr < entry->max_stack) {
>                 fp =3D (unsigned int __user *) (unsigned long) sp;
> diff --git a/arch/powerpc/perf/callchain_64.c b/arch/powerpc/perf/callcha=
in_64.c
> index 115d1c105e8a..30fb61c5f0cb 100644
> --- a/arch/powerpc/perf/callchain_64.c
> +++ b/arch/powerpc/perf/callchain_64.c
> @@ -77,7 +77,6 @@ void perf_callchain_user_64(struct perf_callchain_entry=
_ctx *entry,
>         next_ip =3D perf_arch_instruction_pointer(regs);
>         lr =3D regs->link;
>         sp =3D regs->gpr[1];
> -       perf_callchain_store(entry, next_ip);
>
>         while (entry->nr < entry->max_stack) {
>                 fp =3D (unsigned long __user *) sp;
> --
> 2.53.0
>
>

