Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E58C6FD1C
	for <linux-perf-users@archiver.kernel.org>; Mon, 20 Mar 2023 21:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjCTVbd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 20 Mar 2023 17:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjCTVbb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 20 Mar 2023 17:31:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173102BEFB;
        Mon, 20 Mar 2023 14:30:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D8A2A1F8BE;
        Mon, 20 Mar 2023 21:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1679347801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/ddAULa4pkvzGNv1mnYT99lOGWcrJyo3XNZPP739YIE=;
        b=QSHuC3/g57DmUtUx4DNCvsBsXOFcazWwvUzxukB2g2yYyC2RNJjD4VBZiTa8YTLKk2KzrE
        iyAhgXuDxaST2B/TFpJnxzI96sxnQEwBvDmdQ92Ruc+LScVlzcQyJoeD09LPxE9kNn/t7I
        Z/DdEWJE/zkexkyf4OEC7m/37FpN28k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1679347801;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/ddAULa4pkvzGNv1mnYT99lOGWcrJyo3XNZPP739YIE=;
        b=Q3iQEuTJ4rTSTPPhgXyyhOhaqoboe/LoLrGXe9hrtXn1PyQbGaAmnl5davH7yfijaH4CGV
        ORYMFjmzcRt2UpAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9F25413A00;
        Mon, 20 Mar 2023 21:30:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rQH+JFnQGGQFfAAAMHmgww
        (envelope-from <bwiedemann@suse.de>); Mon, 20 Mar 2023 21:30:01 +0000
Message-ID: <5064f88a-952a-6f3f-f280-e76e09603c1b@suse.de>
Date:   Mon, 20 Mar 2023 22:30:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>, Ben Hutchings <benh@debian.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230320201841.1133-1-bwiedemann@suse.de>
 <CAP-5=fUGbT8=spY=e6NPJvf_+Ct6VksFzWM6Eybf=gst_J=Xmw@mail.gmail.com>
From:   "Bernhard M. Wiedemann" <bwiedemann@suse.de>
Subject: Re: [PATCH] perf jevents: Sort list of input files
In-Reply-To: <CAP-5=fUGbT8=spY=e6NPJvf_+Ct6VksFzWM6Eybf=gst_J=Xmw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------WQN5xf3Y85YaxMlfHzlmzIRU"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------WQN5xf3Y85YaxMlfHzlmzIRU
Content-Type: multipart/mixed; boundary="------------1Bj2UOMUuaRY2kKGxwECx9Am";
 protected-headers="v1"
From: "Bernhard M. Wiedemann" <bwiedemann@suse.de>
To: Ian Rogers <irogers@google.com>, Ben Hutchings <benh@debian.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <5064f88a-952a-6f3f-f280-e76e09603c1b@suse.de>
Subject: Re: [PATCH] perf jevents: Sort list of input files
References: <20230320201841.1133-1-bwiedemann@suse.de>
 <CAP-5=fUGbT8=spY=e6NPJvf_+Ct6VksFzWM6Eybf=gst_J=Xmw@mail.gmail.com>
In-Reply-To: <CAP-5=fUGbT8=spY=e6NPJvf_+Ct6VksFzWM6Eybf=gst_J=Xmw@mail.gmail.com>

--------------1Bj2UOMUuaRY2kKGxwECx9Am
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQoNCk9uIDIwLzAzLzIwMjMgMjEuNDgsIElhbiBSb2dlcnMgd3JvdGU6DQo+IEkgdGhpbmsg
dGhpcyBtYXkgYWxyZWFkeSBiZSBhZGRyZXNzZWQgYnkgc29ydGluZyBwcmlvciB0byBvdXRw
dXQ6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyMjA4MTIyMzA5NDkuNjgzMjM5
LTUtaXJvZ2Vyc0Bnb29nbGUuY29tDQo+IA0KPiBDb3VsZCB5b3UgY29uZmlybT8NCg0KSGkg
SWFuLA0KDQpJIHdhcyB0ZXN0aW5nIG9uIDYuMi42IHdoaWNoIGluY2x1ZGVzIHRoYXQgcGF0
Y2ggYW5kIGl0IHdhcyBzdGlsbCBhZmZlY3RlZC4NClRoZSB0cm91YmxlIHdpdGggc29ydGlu
ZyBhdCB0aGUgZW5kIGlzLCB0aGF0IHRoZXJlIGNhbiBiZSBpbmZsdWVuY2VzIG9mIA0Kb3Jk
ZXJpbmcgaW4gZWFybGllciBwcm9jZXNzaW5nIHN0ZXBzLCB0aGF0IGRvbid0IGdldCBpcm9u
ZWQgb3V0IGJ5IHRoZSANCnNvcnQgbGF0ZXIuDQoNClNvbWUgbW9yZSBleHBlcmltZW50aW5n
IHNob3dlZCB0aGF0IG9ubHkgdGhlIGZ0dyBzY2FuZGlyIG5lZWRlZCBzb3J0aW5nLCANCndo
aWNoIGFsbG93cyB0byBmdXJ0aGVyIHNpbXBsaWZ5IHRoZSBwYXRjaCB0bw0KDQogICAgICAi
IiJSZXBsaWNhdGUgdGhlIGRpcmVjdG9yeS9maWxlIHdhbGtpbmcgYmVoYXZpb3Igb2YgQydz
IC4uLg0KLSAgICBmb3IgaXRlbSBpbiBvcy5zY2FuZGlyKHBhdGgpOg0KKyAgICBmb3IgaXRl
bSBpbiBzb3J0ZWQob3Muc2NhbmRpcihwYXRoKSwga2V5PWxhbWJkYSBlOiBlLm5hbWUpOg0K
ICAgICAgICBhY3Rpb24ocGFyZW50cywgaXRlbSkNCg0KDQpXaXRob3V0IHRoZSBwYXRjaCwg
YSByYW5kb20gZGlmZiBpbiBwbXUtZXZlbnRzLmMgc3RhcnRzIHdpdGgNCi1zdGF0aWMgY29u
c3Qgc3RydWN0IGNvbXBhY3RfcG11X2V2ZW50IHBtZV9hbWR6ZW4yW10gPSB7DQorc3RhdGlj
IGNvbnN0IHN0cnVjdCBjb21wYWN0X3BtdV9ldmVudCBwbWVfc2lsdmVybW9udFtdID0gew0K
DQoNCldoaWxlIEknbSB0ZXN0aW5nIG9uIHNjcmF0Y2ggZXh0NCBmaWxlc3lzdGVtcyB3aGVy
ZSBkaXJpbmRleCBjYXVzZXMgDQpyYW5kb21uZXNzLCB5b3UgY291bGQgYWxzbyB1c2UgdGhl
IGRpc29yZGVyZnMgRlVTRS1maWxlc3lzdGVtIHdpdGggaXRzIA0Kc2h1ZmZsZSBtb2RlIHRv
IGdpdmUgeW91IHJhbmRvbSBvcmRlci4NCg0KQ2lhbw0KQmVybmhhcmQgTS4NCg==

--------------1Bj2UOMUuaRY2kKGxwECx9Am--

--------------WQN5xf3Y85YaxMlfHzlmzIRU
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTykslvYmKwlIQesLNdovN53d8CLgUCZBjQWAUDAAAAAAAKCRBdovN53d8CLkZX
AQCTRtmghVye68AedHh3vbv8qiOuZprWSdWXlu/6UwOg0wD/UXKHMQYgcBztTZu/cI4JZlUfVtTJ
WV8AU99yQUyovQI=
=QLbr
-----END PGP SIGNATURE-----

--------------WQN5xf3Y85YaxMlfHzlmzIRU--
