Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76F3C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 14 Apr 2022 22:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347281AbiDNWtR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 14 Apr 2022 18:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345199AbiDNWtQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 14 Apr 2022 18:49:16 -0400
X-Greylist: delayed 97 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Apr 2022 15:46:49 PDT
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DC2C8BC7
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Apr 2022 15:46:49 -0700 (PDT)
Date:   Thu, 14 Apr 2022 22:46:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
        s=protonmail2; t=1649976407;
        bh=gD40bE7CA3nEbFCC4RvOWqz3pW6a2RcS6zm8BhERlxo=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=C1aVC6ihmrjtj8lQuyquB9RBqnf8GaT44/TGR+XaxR8nMZ6x6GWtkAvp8QODJgNz8
         vAJmQjrWys4Iqn092ieJH35uZoJF5SgB4ShAOb5Wk/eHnQ3gyj9uwuyxK2+Oyygvkt
         DtJvm1Cscy0q8/NH2foPjX32AXJIIN+clYH+TL/n4wLU6NUng5qdiKwFFVhmrhlxDE
         YzrkoThbgG/wTXEJm6NoxJ7B6CVsgDl9P8LXzlU8dmjKuD6TXAPVgPFPiwdrtcp/kO
         7RPD+732T0+G/q+rw91CjFDWYvqbPLM80ceEDcuL/Qm2Yw8HUVPPmYEb6WnbcwPiyI
         RmmdX98keMNzA==
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        =?utf-8?Q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alexander Lobakin <alobakin@pm.me>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Chenbo Feng <fengc@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Daniel Wagner <daniel.wagner@bmw-carit.de>,
        Thomas Graf <tgraf@suug.ch>,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: [PATCH bpf-next 08/11] samples: bpf: fix shifting unsigned long by 32 positions
Message-ID: <20220414223704.341028-9-alobakin@pm.me>
In-Reply-To: <20220414223704.341028-1-alobakin@pm.me>
References: <20220414223704.341028-1-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 32 bit systems, shifting an unsigned long by 32 positions
yields the following warning:

samples/bpf/tracex2_kern.c:60:23: warning: shift count >=3D width of type [=
-Wshift-count-overflow]
        unsigned int hi =3D v >> 32;
                            ^  ~~

The usual way to avoid this is to shift by 16 two times (see
upper_32_bits() macro in the kernel). Use it across the BPF sample
code as well.

Fixes: d822a1926849 ("samples/bpf: Add counting example for kfree_skb() fun=
ction calls and the write() syscall")
Fixes: 0fb1170ee68a ("bpf: BPF based latency tracing")
Fixes: f74599f7c530 ("bpf: Add tests and samples for LWT-BPF")
Signed-off-by: Alexander Lobakin <alobakin@pm.me>
---
 samples/bpf/lathist_kern.c      | 2 +-
 samples/bpf/lwt_len_hist_kern.c | 2 +-
 samples/bpf/tracex2_kern.c      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/samples/bpf/lathist_kern.c b/samples/bpf/lathist_kern.c
index 4adfcbbe6ef4..9744ed547abe 100644
--- a/samples/bpf/lathist_kern.c
+++ b/samples/bpf/lathist_kern.c
@@ -53,7 +53,7 @@ static unsigned int log2(unsigned int v)

 static unsigned int log2l(unsigned long v)
 {
-=09unsigned int hi =3D v >> 32;
+=09unsigned int hi =3D (v >> 16) >> 16;

 =09if (hi)
 =09=09return log2(hi) + 32;
diff --git a/samples/bpf/lwt_len_hist_kern.c b/samples/bpf/lwt_len_hist_ker=
n.c
index 1fa14c54963a..bf32fa04c91f 100644
--- a/samples/bpf/lwt_len_hist_kern.c
+++ b/samples/bpf/lwt_len_hist_kern.c
@@ -49,7 +49,7 @@ static unsigned int log2(unsigned int v)

 static unsigned int log2l(unsigned long v)
 {
-=09unsigned int hi =3D v >> 32;
+=09unsigned int hi =3D (v >> 16) >> 16;
 =09if (hi)
 =09=09return log2(hi) + 32;
 =09else
diff --git a/samples/bpf/tracex2_kern.c b/samples/bpf/tracex2_kern.c
index 5bc696bac27d..6bf22056ff95 100644
--- a/samples/bpf/tracex2_kern.c
+++ b/samples/bpf/tracex2_kern.c
@@ -57,7 +57,7 @@ static unsigned int log2(unsigned int v)

 static unsigned int log2l(unsigned long v)
 {
-=09unsigned int hi =3D v >> 32;
+=09unsigned int hi =3D (v >> 16) >> 16;
 =09if (hi)
 =09=09return log2(hi) + 32;
 =09else
--
2.35.2


