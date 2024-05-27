Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD5710E4
	for <linux-perf-users@vger.kernel.org>; Mon, 27 May 2024 00:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716770374; cv=none; b=GLgC78zs1KWrVOaeWjZGWRTp9/6XVKUHwFj5VPZ/eG1hqL7wufn+7VudQleEQ8/oFvxmaM9oElhjHtP8t1xd6L8w+2h02fkpDtrVtgUA2uqaebsFZ+X7nv4exoNvti5kmWw12muepUFd6IYIMej53tAXa4kwZz4YJgloNw/Z8PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716770374; c=relaxed/simple;
	bh=juU0uVtYHmnPMkzk2FN2Yu9Te3n2UxhruPKevY1oQhw=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:
	 Subject:Content-Type; b=mH1U0ALGMYiRnw8WeWYCcQWrcPcVXofAGnGZp8iztUJgHwJCezvb/zMUwS5I8T66vb4OYxCSS5Z0sRxhn8RWfI18fDJSD1psQxGFQKH81hHfDwHj4LjwsygxgfdApLDzwtmJ1iOdnhEGj/ScLDgqFS/k+xxLmM7xpytHpvkGfZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fuuzetsu.co.uk; spf=pass smtp.mailfrom=fuuzetsu.co.uk; dkim=pass (2048-bit key) header.d=fuuzetsu.co.uk header.i=@fuuzetsu.co.uk header.b=FRByIRDV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H9LXrJ7u; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fuuzetsu.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fuuzetsu.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fuuzetsu.co.uk header.i=@fuuzetsu.co.uk header.b="FRByIRDV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H9LXrJ7u"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.west.internal (Postfix) with ESMTP id AC4C91C000BF;
	Sun, 26 May 2024 20:39:30 -0400 (EDT)
Received: from imap45 ([10.202.2.95])
  by compute3.internal (MEProxy); Sun, 26 May 2024 20:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fuuzetsu.co.uk;
	 h=cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1716770370;
	 x=1716856770; bh=afLz81STAnPd9sOE3+16DDHs2e64CFBnlPrNJfX03AY=; b=
	FRByIRDVseZKw4UIfnANeNSFHfVmtWNTZlyosILf5zd8VqfbTxHx3bWskJSn1d39
	EP7gI7KwS668w1Y+ClE5fMSfFxyPThR+I055/wpIBRIEzRQ5n32KzJ6tUAFczLQ0
	AUze0hO/A0xHWMV0+HPhkSySRAniMlGmiz+y3mgF3t+mVaevXSR7VAlfxZiOKLlB
	FrsFsZJQyxqafgRnJ3BxmLedMrGN4zXRkqFcQaHG8BA1Y2QjbBcheEyYqOdEm7Rq
	J4CTZwwF+0B4P+XA5Gs93OdPrBxdNHfL+0JU7d9NGId+pI8yxsTZ4eA8VjCrwZj8
	EAEA++I2dcOTP9kv/UKs6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716770370; x=
	1716856770; bh=afLz81STAnPd9sOE3+16DDHs2e64CFBnlPrNJfX03AY=; b=H
	9LXrJ7u7WMOZ2D/blYSr/keF4yh2qRyV52eLFm2GEzA5lxiLZ27UKi+DuzUf2qj3
	liPtkIlR4JeUEERM4rqgdolUC+aZFA4UR/+P1db9eJG9KToeo7H1oWGKwW/L47k2
	xfHDfq+gLunVfTM0EqfVHgOwwQgILyB2Ar2sPnQRd6BllvvOk67nASuhc3rD8cKF
	I3qDjzdYgDVML5qGJR8HZCHdNoaeunEjhw4xj4n+UODp72bjkmUD+WxcxYoaYtMI
	CLd/LvEk3BxnGNw/L9RI9JoM0oNW9qAY/n95WVL2FhcvSDemLoaPxkTqxsBOlr3G
	VR6k5mY0cAr4MoHwzLfYQ==
X-ME-Sender: <xms:QdZTZrH3KIfdXD3SHlKuNMe__XO74HQkUJMVjD2BQ8DYxSS2-CVb2w>
    <xme:QdZTZoWYHHilt8uEhUvYnCLOf6liea_TCJMHx4CC-2OyNbY8ATk1h25Bcmq1z5fVt
    UihgFCicX9lqiVptQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejfedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedfofgr
    thgvuhhsiicumfhofigrlhgtiiihkhdfuceofhhuuhiivghtshhusehfuhhuiigvthhsuh
    drtghordhukheqnecuggftrfgrthhtvghrnhepfffhvdefieeiudduvdeufedtuddvkeet
    gfetiedvjeejtddufeetjeevhfekfeevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    dpmhgrphhsrdhmrghpnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepfhhuuhiivghtshhusehfuhhuiigvthhsuhdrtghordhukh
X-ME-Proxy: <xmx:QtZTZtLGML2vNwdqm6hy7b3ZwE3pQRHzvZ5P4lMTsyAqRj07W5k5pA>
    <xmx:QtZTZpG_4ApChA8l4tXi4i63tXe9LXczkANY79bF42vReWJfzUlhpw>
    <xmx:QtZTZhWbvSHk_7fBkZwvo6tjQvCSyEjw-HbR_D2tJuvVaPCnC50Z2w>
    <xmx:QtZTZkOCUmW8l4A4sifWMIH7IplTqr0KVXGjPwTJlsbYDVi2mZ9KHQ>
    <xmx:QtZTZgfMP9jtzXqkybnzsds6c-oO3y2XnZ1YpeHwb_QDUVISnrGdVPwt>
Feedback-ID: ia5d440cb:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id E198D272007C; Sun, 26 May 2024 20:39:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-480-g515a2f54a-fm-20240515.001-g515a2f54
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a8ea965e-1a88-4297-8ef7-8a8e80ae6a4a@app.fastmail.com>
In-Reply-To: 
 <CAP-5=fVpgRgx839qaeEbnOPSeMD5xXUwNv7Jeqe1PQj8yqV9_g@mail.gmail.com>
References: <fd2b28b4-8fc5-45c1-824b-4de4422e8837@app.fastmail.com>
 <CAP-5=fVpgRgx839qaeEbnOPSeMD5xXUwNv7Jeqe1PQj8yqV9_g@mail.gmail.com>
Date: Mon, 27 May 2024 09:37:41 +0900
From: "Mateusz Kowalczyk" <fuuzetsu@fuuzetsu.co.uk>
To: "Ian Rogers" <irogers@google.com>,
 linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: Linux `perf report` regression
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, 25 May 2024, at 5:17 AM, Ian Rogers wrote:
> On Fri, May 24, 2024 at 1:00=E2=80=AFAM Mateusz Kowalczyk
> <fuuzetsu@fuuzetsu.co.uk> wrote:
>>
>> Hi Ian,
>>
>> I have recently upgraded my system and I have found that `perf report=
` no longer gives nice traces.
>>
>> For the same `perf record` capture, I used to get traces like this, w=
ith `perf report --hierarchy -M intel --no-inline`.
>>
>> ```
>> -   98.33%        sim
>>    -   42.66%        sim
>>       -    3.40%        [.] <serde_json::read::StrRead as serde_json:=
:read::Read>::parse_str
>>            ordercache::Reader::open
>>            serde_json::de::from_str
>>            <&mut serde_json::de::Deserializer<R> as serde::de::Deseri=
alizer>::deserialize_struct
>>          + <&mut serde_json::de::Deserializer<R> as serde::de::Deseri=
alizer>::deserialize_map
>> ```
>>
>> However after upgrading, I get the following report on the very same =
file:
>>
>> ```
>> -   98.33%        sim
>>    -   42.66%        sim
>>       -    3.40%        [.] <serde_json::read::StrRead as serde_json:=
:read::Read>::parse_str
>>            0x55e840085c78
>>            0x55e84008fb0d
>>            0x55e8400986d6
>>          + 0x55e840096122
>> ```
>>
>>
>> I have bisected the issue to this commit: https://lore.kernel.org/all=
/20230608232823.4027869-21-irogers@google.com/ a.k.a. `bffb5b0c0976aa46a=
aa961dd19a47c9d6301cfe1`. The working `perf report` is from the commit r=
ight before that, `1981da1fe2499823f626c86c5ba3be6b89844384`.
>>
>> I'm not sure if there's some mailing list I should be trying to repor=
t it at. I can not share the perf capture as-is but I can try to come up=
 with something on Monday that should hopefully reproduce the problem, i=
f necessary.
>
> Thanks Mateusz,
>
> The mailing list to use is linux-perf-users, added. Thanks for the
> bisect, looking at the patch in question it looks like prior to the
> fix there was probably a use after a value had been put. We probably
> need to increase the lifetime of the get/put to avoid the issue you
> are seeing. The reference count checking has some documentation here:
> https://perf.wiki.kernel.org/index.php/Reference_Count_Checking
>
> Looking at the patch, and adding some annotations:
> ```
> --- a/tools/perf/util/callchain.c
> +++ b/tools/perf/util/callchain.c
> @@ -590,6 +590,7 @@ fill_node(struct callchain_node *node, struct
> callchain_cursor *cursor)
>   call->ip =3D cursor_node->ip;
>   call->ms =3D cursor_node->ms;
>   call->ms.map =3D map__get(call->ms.map);
> + call->ms.maps =3D maps__get(call->ms.maps); <---- adding a get should
> be safe, it increases a reference count and shouldn't make the thing
> go away
>   call->srcline =3D cursor_node->srcline;
>
>   if (cursor_node->branch) {
> @@ -649,6 +650,7 @@ add_child(struct callchain_node *parent,
>   list_for_each_entry_safe(call, tmp, &new->val, list) {
>   list_del_init(&call->list);
>   map__zput(call->ms.map);
> + maps__zput(call->ms.maps); <----- a put could be the source of the
> problem, especially a zput that makes the value NULL. However, the
> next line here frees "call" and so we're unlikely to have been using
> it later in the code.
>   free(call);
>   }
>   free(new);
> @@ -1010,10 +1012,16 @@ merge_chain_branch(struct callchain_cursor *cu=
rsor,
>   int err =3D 0;
>
>   list_for_each_entry_safe(list, next_list, &src->val, list) {
> - callchain_cursor_append(cursor, list->ip, &list->ms,
> - false, NULL, 0, 0, 0, list->srcline);
> + struct map_symbol ms =3D {
> + .maps =3D maps__get(list->ms.maps),
> + .map =3D map__get(list->ms.map), <--- gets should be safe
> + };
> + callchain_cursor_append(cursor, list->ip, &ms, false, NULL, 0, 0, 0,
> list->srcline);
>   list_del_init(&list->list);
> + map__zput(ms.map);
> + maps__zput(ms.maps); <--- these puts should match the gets above, so
> should be sound
>   map__zput(list->ms.map);
> + maps__zput(list->ms.maps); <--- these puts are on a value in "list"
> which is freed below, so we should be good.
>   free(list);
>   }
> ```
> Nothing was particularly jumping out from the changes but given the
> reproduction you have you should be able to revert the change in each
> file and narrow down which change is causing the issue.
>
> Thanks,
> Ian
>
>
>
>
>> I thought I'd fire an e-mail in case this is something obvious to you=
 and the fix is simple. I tried to search on the web but I was unable to=
 find anything useful. Maybe most people are using some old version or i=
t's something to do with my setup.
>>
>> Please let me know if I should send this to some mailing list instead=
 -- presumably with a reproduction example.
>>
>> Thank you!
>>
>> --
>> Mateusz K.

Hi again,

I was first able to revert `util/callchain.c` and confirmed that fixed t=
he issue. To narrow it down, I tried commenting out every `maps__zput` t=
hat was added and later even every `map__zput` that already existed but =
nothing fixed the problem.

The only thing that did help was this change:

```diff
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 909f62b3b266..77215cedf35d 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1016,7 +1016,7 @@ merge_chain_branch(struct callchain_cursor *cursor,
                        .maps =3D maps__get(list->ms.maps),
                        .map =3D map__get(list->ms.map),
                };
-               callchain_cursor_append(cursor, list->ip, &ms, false, NU=
LL, 0, 0, 0, list->srcline);
+               callchain_cursor_append(cursor, list->ip, &list->ms, fal=
se, NULL, 0, 0, 0, list->srcline);
                list_del_init(&list->list);
                map__zput(ms.map);
                maps__zput(ms.maps);
```

I don't know _why_ this fixes it unless something weird is happening wit=
h the maps__get or map__get above...?

I was able to confirm on the most recent kernel tree checkout that the s=
ame patch still makes the problem go away. Of course, this is probably n=
ot the right fix but I don't really know what I'm doing...

Maybe this gives some hint about what may be wrong.

Thanks

--
Mateusz K.
