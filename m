Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794952068;
	b=fZMdCgQWIvwE8SLn8ZeBoxYs9UA80Amm4E3N9fj4PQhMMKh0hV+mSDF/hmfUa/sDSU6z
	 UCtLxm1kHq3flTroBK2dpx+jGgdMkEwIbeZyRQPbWxBtX4NVooxfNUIjxkxiDn/DCzyNz
	 Jj6TKWl2nrieOTB/djFKigsfTYepvEri20BDBrVpJync98qW3j8VSAVj1nXFbWXzQTY+Y
	 onE6kVs+sSZFyx98+bbz6FeOlwcvs/PAEdp++ohNXQIH0eIOMB1F/64woEtxl+Ot+39SZ
	 CUir4hP6szjx+Vnh3l1hy4uLtYakkJ8W5EU4y+2dmM6OABGmN8aznk3ZkVzpG96m8PQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794952068;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type;
	bh=vpOOBtKuDULBz9vkdGNDf/DlRcVMG6RbijwbAk547cM=;
	b=R9J7Jmkmf7JdD0fmZ9kHHqdd2GJJMCkBLKlv8Esd3ZBtlESw4dEfos4a/yYbYy9xnt9n
	 af8st27gjYcxdgmYlQFIi51GkvPPJ3XXLSFxC0K/cWmPW7wb+OTl/er96cD0leM9mB9rr
	 y6x4QnnFzRDNHkRTKzuuvE9nRXpvSNer40zgs9pAxvXQSu1V6PSrRzKEaOJ7lgTx6tTRx
	 60ki4OrXFk5A3h33T5Ra5onWIgRtQebbtsMSpLFF/guYS+bIIUCIQ6lfXvvEPIIWX3F5f
	 bH8OAJeN/cUek3rA2CvjI6ZL4oX9XcPfE7octTE1wqjYWKyKc4zETAue6IrRcef37kQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=ocallahan.org;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=ocallahan-org.20260707.gappssmtp.com header.i=@ocallahan-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=sQ9ojPZo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C51D606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 21:47:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C51D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ocallahan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ocallahan-org.20260707.gappssmtp.com header.i=@ocallahan-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=sQ9ojPZo
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b87a1a2babso1479831a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 13:47:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794952066; cv=none;
        d=google.com; s=arc-20260327;
        b=HCvrK4DiR2uMZBUS17KHU1UkvdBtTHFr3a4bgSJpP1AQ507CA9HIYHL9aWI5ul9RuT
         /clyCA6KY/NpqerNz6unuEkzK/IhjCQfQqb7xnQVGKU+tXz9j6ve43NRyoNYNlgR3iRE
         dfuk4L/8atYUF/jJXzIMUqpckC6HCcIBKLu06gWFzPm+jhTZB9TWvtXCJe1uq3dk8p0a
         db//d1mbFTptGni8aO+TXL74Mc/Fs6nvZOoMCNzO1CsJUz6+s8GUT7y1YrEe4wupxmJw
         M+EkMc475LWvEYJg51Q+17Drr9SP8XISzu+6VhfR2GemcMzFxnKXAJ8lzMbAqcut1rBo
         F7rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version
         :dkim-signature;
        bh=vpOOBtKuDULBz9vkdGNDf/DlRcVMG6RbijwbAk547cM=;
        fh=qbgStekF7ISj9GVK+ZhxeyePuHOSRtt9VpWvSQ7vBnw=;
        b=nIjYp635BEJufVVU8FbyECX9/2Zuz1pNNG6TEewo4aqdlxGNOOYSqV2qav2pBPQ79M
         ZtkjTIMgyikNxQnCm0q+DITOpYsBdk2HmjdqbN29jPIxpBY4VCojM6y0cPnWvCUgYsou
         /78yB+AGHdHfu2gw1LdI03WFJXxZ8vZlWQH7gU+ZhvjRJEYtghsnpaIy64daRQJbaWoG
         1EZaXF317ODVXj1NJ9BDXcMBtg/3Ru7mWCGNdN72qiaJ9x0lhqDrtCaBXVwJrFHiqyiS
         ax9AIbytjYwlssSWt7EkAd30z2pR76yWJTkgy2S3Gr9Q07q+RQHaDSHGb3RwaLVRAmRt
         HxcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ocallahan-org.20260707.gappssmtp.com; s=20260707; t=1794952066; x=1795556866; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vpOOBtKuDULBz9vkdGNDf/DlRcVMG6RbijwbAk547cM=;
        b=sQ9ojPZoSwGIvhNsN2zWbo0GyOP85wRKSN6ffCHDaXz8bNexlIBKcrp/jb/T/jitpD
         pRlBgaj4Mg9j8jze2iFWu9n+l1se6EDYZ50cncohlhAJgusLLWRp0VqJ+BBW5AZH+Ee7
         Alo+oOLYuN3v+MBmsBmRs7Ur9xONV6gK3vIVCb4lvTjfgkbJ6AwybJEBxaR+cgMCfAvY
         elAbmODvx2ZtRDMaA79sErYIgAwbE3NuE7YKeNjRyYWDGW4InSeLi1UP2X5DLM5EYmsU
         zuOFUgLoGtYwxz7OgGyXNPy0Iyd1MkGJW/WPM1YS+Z2ibHxbtk676KZV6MplYiFLG5fn
         dkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794952066; x=1795556866;
        h=content-type:cc:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vpOOBtKuDULBz9vkdGNDf/DlRcVMG6RbijwbAk547cM=;
        b=ufkS4mboUuZZ0tSSk8NVbIKzMJ9TJbH8RicuZPfrBbjg3eFoXn9dJBboudRzmpzJz3
         yK32dd6p69xdz72mq5St5aHVgknB24RbN72GCwrdYT7cq07+YD49iQ2zhQQ8DTwN07Wa
         jPEdw3MwjcGHCh4W7YsJI2uB26rrM++3Y5dU35FIDIfrbDSNy5IGQuWuBRRX1Jj0lF/f
         Qrql4hyCD/7kJOzMIRSXkqBMyrnjKCeeqhbbdxyTdpdNe+EtmNtWso+uMpMOPY3pQM5B
         hKaF6CMd6MCd00CJG6Jl/+QyhnEBkhEMKayukmvkm4P+neU7w0+irhpE/V+XNXVpCPEI
         4XGQ==
X-Forwarded-Encrypted: i=1; AL+hErE+gC4CcZRVjxMv0TX74nncAdXl1RoFamHdPI4OELt1wuKGOG6IvRH1AHz4AE7B7Ki+gFvGX2dSoHb3Pm+HCHAI@vger.kernel.org
X-Gm-Message-State: APuU4Z98Ar8UP1U/+OaEER0/hxF8z/Ym1r3QcPhdSCoEZ90MNHuq+wXM
	O5h5m9ACemDL7A1CMOg84tNTyqBA1hbHHEBOeEZoIxBgdFEXu5aFHah4CZbDs+pK7i/lCrhD1yZ
	PPz8m4RD0+MT5SXBvU5odqqg6P8SsoI4=
X-Gm-Gg: AYBFou3cOv6dzECSPKdMhXj2WLkcXDmgLhhn97uq5ReJ6791NWJP5BYaYyRzFZ1/tAo
	OqFThdzkuz62EA4IXkgV8FZgYa4wq8tQaIVyag9vWcTd6Q/i7LUjDX467lunzPLrf0VspQ68m8d
	gKfyYapqZvOX0mAp3BfLHO3jlo47LrDZFSnz0V8WjakzHjHuuWcLCDBpatPGUDyMmKj5Rt1bvYT
	Mdu6dr46yMgyukoFyP6UPSYEwrz4SKgdjffiIEF1bEuIMar2gMRXldooxBLn7psZiAre4Q0doVA
	B5UDuMasTIWeNRAu6WoaTcOJKaaR5xstGoJqgNMYXAEaRc6MI6NFTsfoOREIMIfp8rznUFp+aY+
	L+DnG2eoDVk8Uw7g6++rvSs4u60wyDtTNRGzc49IpYOdQKxPdA5g7nCqGm0Zu5f8SNL4rIdUCLL
	faOEWxxd2rhG0I8CWkN/vWSK5k5j2ncuA8q1p/j7kNYgbMfY/941AkaldOdQZKGK1jhdhayq+4V
	XSWLKV3Oi2JxXIP3IhSAix0ZvNVumV72ZSyJLMIT5r//aBYDwq+
X-Received: by 2002:aa7:da4c:0:b0:6b7:cb66:682a with SMTP id
 4fb4d7f45d1cf-6b88815c0aamr273193a12.16.1794952066290; Tue, 17 Nov 2026
 13:47:46 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Reply-To: robert@ocallahan.org
From: "Robert O'Callahan" <robert@ocallahan.org>
Date: Wed, 18 Nov 2026 10:47:33 +1300
X-Gm-Features: AclHuK_W5EoVeEwhkEt8vYm6YS2532tt9Z3r_pUJEKAKCImxRZu4iFQtMmCjyaU
Message-ID: <CAOp6jLZoYFuEZxfrvQBbGNyqYpgW2Tbt3qO3GGmvF1qwgcjXDQ@mail.gmail.com>
Subject: Re: [DISCUSSION] Three problems behind broken "perf --call-graph
 dwarf" on AMD: IP and stack dump mismatch, libdw fails on lld's layout, and
 the unwinder fallback never runs
To: Ian Rogers <irogers@google.com>
Cc: gennady.kupava@gmail.com, linux-perf-users@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000004d30cc06607fd820"

--0000000000004d30cc06607fd820
Content-Type: text/plain; charset="UTF-8"

> > Problem 2: libdw cannot unwind through lld's default segment layout
> > ===================================================================
> >
> > The practical reach of this is larger than a synthetic test.  Every Android
> > NDK build is linked with lld, and lld is the default in a growing number of
> > clang configurations.
>
> Did you confirm the bug was in perf or in libdw? There are fixes in
> libdw and my experiences with newer libdw's have been more positive
> than older ones.

eu-stack works OK, and that uses libdw, so the bug seems to be in perf.

LLM-generated reproducer attached.

Rob
-- 
Su ot deraeppa sah dna Rehtaf eht htiw saw hcihw, efil lanrete eht uoy
ot mialcorp ew dna, ti ot yfitset dna ti nees evah ew; deraeppa efil
eht. Efil fo Drow eht gninrecnoc mialcorp ew siht - dehcuot evah sdnah
ruo dna ta dekool evah ew hcihw, seye ruo htiw nees evah ew hcihw,
draeh evah ew hcihw, gninnigeb eht morf saw hcihw taht.

--0000000000004d30cc06607fd820
Content-Type: application/x-shellscript; name="repro.sh"
Content-Disposition: attachment; filename="repro.sh"
Content-Transfer-Encoding: base64
Content-ID: <f_mwl83er81>
X-Attachment-Id: f_mwl83er81

IyEvYmluL3NoCiMgcGVyZiByZWNvcmQgLS1jYWxsLWdyYXBoPWR3YXJmLCB3aXRoIHBlcmYncyBs
aWJkdyB1bndpbmRpbmcsIGZhaWxzIG9uCiMgZXhlY3V0YWJsZXMgbGlua2VkIHdpdGggbGQubGxk
J3MgZGVmYXVsdCBsYXlvdXQgKC0tcm9zZWdtZW50CiMgLXogbm9zZXBhcmF0ZS1jb2RlKS4gVGhl
cmUgdGhlIFIgYW5kIFJYIFBUX0xPQURzIHNoYXJlIGZpbGUgcGFnZXMsIHNvIHRoZQojIFJYIHNl
Z21lbnQncyBwX3ZhZGRyICE9IHBfb2Zmc2V0LiBldS1zdGFjaywgdXNpbmcgbGliZHcgZGlyZWN0
bHksIHVud2luZHMKIyB0aGUgc2FtZSBleGVjdXRhYmxlcyBmaW5lLgojCiMgVXNhZ2U6IC4vcmVw
cm8uc2ggW2RpcmVjdG9yeSBob2xkaW5nIGxkLmxsZCwgZm9yIGdjYyAtQl0KIyBOZWVkczogZ2Nj
LCBHTlUgbGQsIGxkLmxsZCwgcGVyZiAod2l0aCBsaWJkdyB1bndpbmRpbmcpLCBldS1zdGFjay4K
c2V0IC1lCmNkICIkKGRpcm5hbWUgIiQwIikiCkI9JHsxOistQiQxfQoKYnVpbGQoKSB7ICMgbmFt
ZSwgZmxhZ3MuLi4KICAgIG5hbWU9JDEKICAgIHNoaWZ0CiAgICBnY2MgLU8yIC1nICIkQCIgLW8g
IiRuYW1lIiBzcGluLmMKICAgIGJpbnM9IiRiaW5zICRuYW1lIgp9CmJpbnM9CmJ1aWxkIGJmZCAt
ZnVzZS1sZD1iZmQgLW5vLXBpZQpidWlsZCBiZmQtcGllIC1mdXNlLWxkPWJmZCAtZlBJRSAtcGll
CmJ1aWxkIGxsZCAkQiAtZnVzZS1sZD1sbGQgLW5vLXBpZQpidWlsZCBsbGQtcGllICRCIC1mdXNl
LWxkPWxsZCAtZlBJRSAtcGllCmJ1aWxkIGxsZC1waWUtc2VwYXJhdGUgJEIgLWZ1c2UtbGQ9bGxk
IC1mUElFIC1waWUgLVdsLC16LHNlcGFyYXRlLWxvYWRhYmxlLXNlZ21lbnRzCgplY2hvICI9PSB2
ZXJzaW9ucyIKcGVyZiB2ZXJzaW9uCnBlcmYgdmVyc2lvbiAtLWJ1aWxkLW9wdGlvbnMgfCBncmVw
IC1FICdsaWJkdy1kd2FyZi11bndpbmR8bGlidW53aW5kJwpldS1zdGFjayAtLXZlcnNpb24gfCBo
ZWFkIC0xCmdjYyAtLXZlcnNpb24gfCBoZWFkIC0xCnVuYW1lIC1yCgpmb3IgYmluIGluICRiaW5z
OyBkbwogICAgZWNobwogICAgZWNobyAiPT0gJGJpbiIKICAgIHJlYWRlbGYgLXAgLmNvbW1lbnQg
IiRiaW4iIHwgZ3JlcCAtbyAnTGlua2VyOiBMTERbXihdKicgfHwgZWNobyAiR05VIGxkIgogICAg
cmVhZGVsZiAtbFcgIiRiaW4iIHwgZ3JlcCAtRSAnXiArTE9BRCcKICAgIHBlcmYgcmVjb3JkIC1x
IC1lIHRhc2stY2xvY2sgLS1jYWxsLWdyYXBoPWR3YXJmIC1vICIkYmluLnBlcmYuZGF0YSIgIi4v
JGJpbiIgPi9kZXYvbnVsbCAyPiYxCiAgICAjIFNhbXBsZXMgYXJlIHNlcGFyYXRlZCBieSBibGFu
ayBsaW5lczogYSBoZWFkZXIsIHRoZW4gYSBmcmFtZSBhIGxpbmUuCiAgICBwZXJmIHNjcmlwdCAt
aSAiJGJpbi5wZXJmLmRhdGEiIDI+L2Rldi9udWxsIHwgYXdrICcKICAgICAgICBCRUdJTiB7IFJT
ID0gIiIgfQogICAgICAgIHsgbisrIH0KICAgICAgICAvIG1haW5cKy8geyBtYWluKysgfQogICAg
ICAgIG4gPT0gMTAwMCB7IHNhbXBsZSA9ICQwIH0KICAgICAgICBFTkQgewogICAgICAgICAgICBw
cmludGYgInBlcmY6ICVkIG9mICVkIHNhbXBsZXMgdW53aW5kIHRvIG1haW4oKVxuIiwgbWFpbiwg
bgogICAgICAgICAgICBwcmludCAic2FtcGxlIDEwMDA6XG4iIHNhbXBsZQogICAgICAgIH0nCiAg
ICAiLi8kYmluIiAxMDAwMDAwMDAwID4vZGV2L251bGwgJgogICAgcGlkPSQhCiAgICBzbGVlcCAx
CiAgICBlY2hvICJldS1zdGFjayAtcDoiCiAgICBldS1zdGFjayAtcCAkcGlkIDI+JjEgfCBncmVw
ICdeIycgfCBoZWFkIC02CiAgICBraWxsICRwaWQKICAgIHdhaXQgJHBpZCAyPi9kZXYvbnVsbCB8
fCB0cnVlCiAgICBybSAtZiAiJGJpbi5wZXJmLmRhdGEiCmRvbmUK
--0000000000004d30cc06607fd820
Content-Type: text/markdown; charset="US-ASCII"; name="README.md"
Content-Disposition: attachment; filename="README.md"
Content-Transfer-Encoding: base64
Content-ID: <f_mwl83eqr0>
X-Attachment-Id: f_mwl83eqr0

cGVyZiAtLWNhbGwtZ3JhcGg9ZHdhcmYgKGxpYmR3KSBjYW4ndCB1bndpbmQgbGQubGxkJ3MgZGVm
YXVsdCBsYXlvdXQKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09CgpGaWxlczogYHNwaW4uY2AgKHRoZSB0ZXN0IHByb2dy
YW0pLCBgcmVwcm8uc2hgIChidWlsZHMgYW5kIGNoZWNrcyBpdCksCmBvdXRwdXQudHh0YCAoaXRz
IG91dHB1dCBoZXJlKS4KCiAgICAuL3JlcHJvLnNoIFtkaXJlY3RvcnkgaG9sZGluZyBsZC5sbGQs
IGZvciBnY2MgLUJdCgpTdW1tYXJ5Ci0tLS0tLS0KCldpdGggcGVyZidzIGxpYmR3IHVud2luZGlu
ZyAoYXMgZGlzdHJpYnV0aW9ucyBub3cgYnVpbGQgcGVyZiwgd2l0aG91dApsaWJ1bndpbmQpLCBg
cGVyZiByZWNvcmQgLS1jYWxsLWdyYXBoPWR3YXJmYCBnZXRzIG5vIHVzYWJsZSBjYWxsIGNoYWlu
cyBmcm9tCmV4ZWN1dGFibGVzIGxpbmtlZCBieSBsZC5sbGQgd2l0aCBpdHMgZGVmYXVsdCBsYXlv
dXQgKGAtLXJvc2VnbWVudAoteiBub3NlcGFyYXRlLWNvZGVgKS4gVGhhdCBsYXlvdXQgcGFja3Mg
dGhlIFIgYW5kIFJYIFBUX0xPQURzIGludG8gdGhlIHNhbWUKZmlsZSBwYWdlcywgc28gdGhlIFJY
IHNlZ21lbnQncyBwX3ZhZGRyICE9IHBfb2Zmc2V0IChoZXJlOiBvZmZzZXQgMHg2YTAsCnZhZGRy
IDB4MTZhMCkuIEl0J3MgdGhlIGRlZmF1bHQgZm9yIFJ1c3QsIHdoaWNoIGxpbmtzIHdpdGggcnVz
dC1sbGQuCgpgZXUtc3RhY2sgLXBgIHVud2luZHMgdGhlIHNhbWUgcnVubmluZyBleGVjdXRhYmxl
cyBjb3JyZWN0bHksIHNvIGxpYmR3IGl0c2VsZgpjb3BlcyB3aXRoIHRoZSBsYXlvdXQ6IHRoZSBi
dWcgbG9va3MgdG8gYmUgaW4gaG93IHBlcmYgc2V0cyB1cCBsaWJkdyBmb3IgdGhlCmV4ZWN1dGFi
bGUgKGl0cyBsb2FkIGJpYXMpLCBub3QgaW4gZWxmdXRpbHMuIExpbmtpbmcgd2l0aCBsZC5sbGQK
YC16IHNlcGFyYXRlLWxvYWRhYmxlLXNlZ21lbnRzYCAocF92YWRkciA9PSBwX29mZnNldCkgYXZv
aWRzIGl0LgoKU2FtcGxlcywgb3V0IG9mIGFib3V0IDI4MDAsIHdob3NlIGNhbGwgY2hhaW5zIHJl
YWNoIG1haW4oKSAoc3Bpbi5jIHNwZW5kcwpuZWFybHkgYWxsIGl0cyB0aW1lIGluIGxlYWYoKSA8
LSBtaWQoKSA8LSBtYWluKCkpOgoKfCBleGVjdXRhYmxlICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8IHBlcmYgIHwgZXUtc3RhY2sgfAp8LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwtLS0tLS0tfC0tLS0tLS0tLS18CnwgR05VIGxkLCBubyBQ
SUUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAyODA5ICB8IG9rICAgICAgIHwKfCBH
TlUgbGQsIFBJRSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDI4NDkgIHwgb2sg
ICAgICAgfAp8IGxkLmxsZCwgbm8gUElFICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
MCAobm8gZnJhbWVzIGF0IGFsbCkgfCBvayB8CnwgbGQubGxkLCBQSUUgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCA0ICAgICB8IG9rICAgICAgIHwKfCBsZC5sbGQsIFBJRSwgYC16
IHNlcGFyYXRlLWxvYWRhYmxlLXNlZ21lbnRzYCB8IDI4MjggIHwgb2sgICAgICAgfAoKRm9yIHRo
ZSBsZC5sbGQgUElFLCBhIHR5cGljYWwgY2hhaW4gc2tpcHMgc3RyYWlnaHQgZnJvbSBsZWFmKCkg
dG8KYF9fbGliY19zdGFydF9tYWluYCwgYXMgaWYgdGhlIHdyb25nIENGSSB3ZXJlIGFwcGxpZWQs
IHdoaWNoIGlzIGNvbnNpc3RlbnQKd2l0aCBhIHdyb25nIGxvYWQgYmlhczoKCiAgICBsZWFmKzB4
MzAgKGxsZC1waWUpCiAgICBfX2xpYmNfc3RhcnRfbWFpbkBAR0xJQkNfMi4zNCsweDg3IChsaWJj
LnNvLjYpCiAgICBfc3RhcnQrMHgyNCAobGxkLXBpZSkKCkZvciB0aGUgbm9uLVBJRSBsZC5sbGQg
ZXhlY3V0YWJsZSwgc2FtcGxlcyBoYXZlIG5vIHVzZXIgZnJhbWVzIGF0IGFsbC4KClBlcmYncyBs
aWJ1bndpbmQgcGF0aCBoYWQgdGhlIHNhbWUga2luZCBvZiBwcm9ibGVtLCBmaXhlZCBpbiAyMDIy
IGJ5CiJwZXJmIHVud2luZDogRml4IHNlZ2Jhc2UgZm9yIGxkLmxsZCBsaW5rZWQgb2JqZWN0cyIg
KGRjMmNmNGNhODY2Zik7IHRoZQpsaWJkdyBwYXRoIHNlZW1zIHRvIG5lZWQgdGhlIGVxdWl2YWxl
bnQuCgpWZXJzaW9uczogcGVyZiA3LjMuNCAoRmVkb3JhIDQ0LCBsaWJkdy1kd2FyZi11bndpbmQg
b24sIGxpYnVud2luZCBvZmYpLAplbGZ1dGlscyAwLjE5Nywga2VybmVsIDcuMy4zLCBnY2MgMTYu
Mi4xLCBMTEQgMjMuMS41IChmcm9tIHRoZSBSdXN0IDEuMTAwCnRvb2xjaGFpbiksIHg4Nl82NC4K
ClJlbGF0ZWQ6IGxsdm0vbGx2bS1wcm9qZWN0IzUzMTU2OyB0aGUgbGludXgtcGVyZi11c2VycyB0
aHJlYWQgIltESVNDVVNTSU9OXQpUaHJlZSBwcm9ibGVtcyBiZWhpbmQgYnJva2VuICdwZXJmIC0t
Y2FsbC1ncmFwaCBkd2FyZicgb24gQU1EIiAoQXVndXN0CjIwMjYpLCB3aG9zZSBwcm9ibGVtIDIg
aXMgdGhpcy4K
--0000000000004d30cc06607fd820
Content-Type: text/x-csrc; charset="US-ASCII"; name="spin.c"
Content-Disposition: attachment; filename="spin.c"
Content-Transfer-Encoding: base64
Content-ID: <f_mwl83erd2>
X-Attachment-Id: f_mwl83erd2

LyogU3BlbmRzIG5lYXJseSBhbGwgaXRzIHRpbWUgaW4gbGVhZigpLCBjYWxsZWQgdmlhIG1pZCgp
IGZyb20gbWFpbigpLCBzbwogICBldmVyeSBzYW1wbGUncyBjYWxsIGNoYWluIHNob3VsZCByZWFj
aCBtYWluLiAqLwojaW5jbHVkZSA8c3RkaW8uaD4KI2luY2x1ZGUgPHN0ZGxpYi5oPgoKX19hdHRy
aWJ1dGVfXygobm9pbmxpbmUpKSBsb25nIGxlYWYobG9uZyBpKSB7CiAgICBsb25nIHMgPSAwOwog
ICAgZm9yIChsb25nIGogPSAwOyBqIDwgMTAwMDsgaisrKQogICAgICAgIHMgKz0gKGkgKiBqKSBe
IGo7CiAgICByZXR1cm4gczsKfQoKX19hdHRyaWJ1dGVfXygobm9pbmxpbmUpKSBsb25nIG1pZChs
b25nIGkpIHsgcmV0dXJuIGxlYWYoaSkgKyAxOyB9CgppbnQgbWFpbihpbnQgYXJnYywgY2hhciAq
KmFyZ3YpIHsKICAgIGxvbmcgbiA9IGFyZ2MgPiAxID8gYXRvbChhcmd2WzFdKSA6IDMwMDAwMDA7
CiAgICBsb25nIHMgPSAwOwogICAgZm9yIChsb25nIGkgPSAwOyBpIDwgbjsgaSsrKQogICAgICAg
IHMgKz0gbWlkKGkpOwogICAgcHJpbnRmKCIlbGRcbiIsIHMpOwogICAgcmV0dXJuIDA7Cn0K
--0000000000004d30cc06607fd820--
