From: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: [PATCH v2] perf report: distinguish between inliners in the same function
Date: Tue, 16 May 2017 15:18:13 +0200
Message-ID: <2100411.JFybRMHOWM@agathebauer>
References: <20170503213536.13905-1-milian.wolff@kdab.com> <25337947.y8Q11MWckQ@milian-kdab2> <20170516005332.GA4885@sejong>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2499447.09gGyLnWxM"; micalg="sha1"; protocol="application/pkcs7-signature"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:33656 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752303AbdEPNSS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 16 May 2017 09:18:18 -0400
In-Reply-To: <20170516005332.GA4885@sejong>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>, kernel-team@lge.com

--nextPart2499447.09gGyLnWxM
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Dienstag, 16. Mai 2017 02:53:32 CEST Namhyung Kim wrote:
> On Mon, May 15, 2017 at 12:01:54PM +0200, Milian Wolff wrote:
> > On Monday, May 15, 2017 3:21:58 AM CEST Namhyung Kim wrote:
> > > Hi Milian,
> > >=20
> > > On Sun, May 14, 2017 at 08:10:50PM +0200, Milian Wolff wrote:
> > > > On Freitag, 12. Mai 2017 15:01:29 CEST Namhyung Kim wrote:
> > > > > On Fri, May 12, 2017 at 12:37:01PM +0200, Milian Wolff wrote:
> > > > > > On Mittwoch, 10. Mai 2017 07:53:52 CEST Namhyung Kim wrote:
> > > > > > > Hi,
> > > > > >=20
> > > > > > > On Wed, May 03, 2017 at 11:35:36PM +0200, Milian Wolff wrote:
> > > > > > <snip>
> > > > > >=20
> > > > > > > > +static enum match_result match_chain_srcline(struct
> > > > > > > > callchain_cursor_node
> > > > > > > > *node, +					     struct callchain_list *cnode)
> > > > > > > > +{
> > > > > > > > +	char *left =3D get_srcline(cnode->ms.map->dso,
> > > > > > > > +				 map__rip_2objdump(cnode->ms.map, cnode->ip),
> > > > > > > > +				 cnode->ms.sym, true, false);
> > > > > > > > +	char *right =3D get_srcline(node->map->dso,
> > > > > > > > +				  map__rip_2objdump(node->map, node->ip),
> > > > > > > > +				  node->sym, true, false);
> > > > > > > > +	enum match_result ret =3D match_chain_strings(left, right=
);
> > > > > > >=20
> > > > > > > I think we need to check inlined srcline as well.  There might
> > > > > > > be a
> > > > > > > case that two samples have different addresses (and from
> > > > > > > different
> > > > > > > callchains) but happens to be mapped to a same srcline IMHO.
> > > > > >=20
> > > > > > I think I'm missing something, but isn't this what this function
> > > > > > provides?
> > > > > > The function above is now being used by the match_chain_inliner
> > > > > > function
> > > > > > below.
> > > > > >=20
> > > > > > Ah, or do you mean for code such as this:
> > > > > >=20
> > > > > > ~~~~~
> > > > > > inline_func_1(); inline_func_2();
> > > > > > ~~~~~
> > > > > >=20
> > > > > > Here, both branches could be inlined into the same line and the
> > > > > > same
> > > > > > issue
> > > > > > would occur, i.e. different branches get collapsed into the fir=
st
> > > > > > match
> > > > > > for
> > > > > > the given srcline?
> > > > > >=20
> > > > > > Hm yes, this should be fixed too.
> > > > >=20
> > > > > OK.
> > > > >=20
> > > > > > But, quite frankly, I think it just shows more and more that the
> > > > > > current
> > > > > > inliner support is really fragile and leads to lots of issues
> > > > > > throughout
> > > > > > the code base as the inlined frames are different from non-inli=
ned
> > > > > > frames, but should most of the same be handled just like them.
> > > > > >=20
> > > > > > So, maybe it's time to once more think about going back to my
> > > > > > initial
> > > > > > approach: Make inlined frames code-wise equal to non-inlined
> > > > > > frames,
> > > > > > i.e.
> > > > > > instead of requesting the inlined frames within match_chain, do=
 it
> > > > > > outside
> > > > > > and create callchain_node/callchain_cursor instances (not sure
> > > > > > which
> > > > > > one
> > > > > > right now) for the inlined frames too.
> > > > > >=20
> > > > > > This way, we should be able to centrally add support for inlined
> > > > > > frames
> > > > > > and
> > > > > > all areas will benefit from it:
> > > > > >=20
> > > > > > - aggregation by srcline/function will magically work
> > > > > > - all browsers will automatically display them, i.e. no longer
> > > > > > need to
> > > > > > duplicate the code for inliner support in perf script, perf rep=
ort
> > > > > > tui/
> > > > > > stdio/...
> > > > > > - we can easily support --inline in other tools, like `perf tra=
ce
> > > > > > --call-
> > > > > > graph`
> > > > > >=20
> > > > > > So before I invest more time trying to massage match_chain to
> > > > > > behave
> > > > > > well
> > > > > > for inline nodes, can I get some feedback on the above?
> > > > >=20
> > > > > Fair enough.  I agree that it'd be better adding them as separate
> > > > > callchain nodes when resolving callchains.
> > > >=20
> > > > Can you, or anyone else more involved with the current callchain co=
de,
> > > > guide me a bit?
> > > >=20
> > > > My previous attempt at doing this can be seen here:
> > > > https://github.com/milianw/linux/commit/
> > > > 71d031c9d679bfb4a4044226e8903dd80ea601b3
> > > >=20
> > > > There are some issues with that. Most of it boils down to the quest=
ion
> > > > of
> > > > how to feed an inlined frame into a callchain_cursor_node. The latt=
er
> > > > contains a symbol* e.g. and users of that class currently rely on
> > > > using
> > > > the IP to find e.g. the corresponding srcline.
> > > >=20
> > > > From what I can see, we either have to hack inline nodes in there, =
cf.
> > > > my
> > > > original approach in the github repo above. Or, better, we would ha=
ve
> > > > to
> > > > (heavily?) refactor the callchain_cursor_node struct and the code
> > > > depending on it. What I have in mind would be something like adding
> > > > two
> > > > members to this struct:
> > > >=20
> > > > const char* funcname;
> > > > const char* srcline;
> > > >=20
> > > > For non-inlined frames, the funcname aliases the `symbol->name` val=
ue,
> > > > and
> > > > the srcline is queried as-needed. For inlined frames the values from
> > > > the
> > > > inlined node struct are used. The inlined frames for a given code
> > > > location would all share the same symbol and ip.
> > > >=20
> > > > Would that be OK as a path forward?
> > >=20
> > > I think you'd be better adding (fake) dso and sym to keep the inline
> > > information.  The fake dso can be paired with the original dso and
> > > maintain a tree of (inlined) symbols.  You may need a fake map to
> > > point the fake dso then.  It seems a bit compilcated but that way the
> > > code will be more consistent and easier to handle (e.g. for caching
> > > and/or deletion) IMHO.
> >=20
> > Can you expand on this please? How would that solve the problem of find=
ing
> > a function name or srcline for a given inline frame?
> >=20
> > I.e.: the function name is, currently, part of the sym. So the fake
> > dso/map
> > would contain an internal, fake, string table which fake symbols could
> > leverage for the function name?
> >=20
> > Sounds like doable, but also sounds like *a lot* of work. And I don't s=
ee
> > how that would solve the srcline situation: That one is queried on-dema=
nd
> > based on the IP of a frame. I would say that inline frames should keep
> > the IP of the first non-inlined frame. But that would make it impossible
> > to find the srcline for the N'th inlined frame... Am I missing somethin=
g?
>=20
> I agree that srcline info can be kept in callchain cursor nodes, but I
> still think function name should be in (fake) symbols.  Sharing a
> symbol for all inlined frames would not work for the children mode
> IMHO.

I'm running into a bit of trouble here. I hoped to be able to store the=20
inlined symbol in the DSO to reuse it for other inlined entries that use th=
e=20
same function. I also hope that this will then take care of the deletion of=
=20
the fake symbols, once the dso is freed.

To do this, I thought I could use dso__find_symbol_by_name and, if nothing =
was=20
found, I create the new fake symbol by symbol__new and insert it via=20
dso__insert_symbol. Apparently, I also need to update the sorted lookup tab=
le,=20
so I call dso__sort_by_name, but that then leads to crashes:

=3D=3D22675=3D=3D Invalid write of size 8
=3D=3D22675=3D=3D    at 0x4D89FC: rb_link_node (rbtree.h:82)
=3D=3D22675=3D=3D    by 0x4D89FC: symbols__insert_by_name (symbol.c:387)
=3D=3D22675=3D=3D    by 0x4D89FC: symbols__sort_by_name (symbol.c:398)
=3D=3D22675=3D=3D    by 0x4D89FC: dso__sort_by_name (symbol.c:512)
=3D=3D22675=3D=3D    by 0x4EB704: unwind_entry (machine.c:2061)
=3D=3D22675=3D=3D    by 0x55BCF7: entry (unwind-libunwind-local.c:600)
=3D=3D22675=3D=3D    by 0x55BCF7: get_entries (unwind-libunwind-local.c:723)
=3D=3D22675=3D=3D    by 0x55BE01: _unwind__get_entries (unwind-libunwind-lo=
cal.c:745)
=3D=3D22675=3D=3D    by 0x4E8B20: sample__resolve_callchain (callchain.c:10=
16)
=3D=3D22675=3D=3D    by 0x5196F9: hist_entry_iter__add (hist.c:1039)
=3D=3D22675=3D=3D    by 0x448044: process_sample_event (builtin-report.c:20=
4)
=3D=3D22675=3D=3D    by 0x4F61DD: perf_evlist__deliver_sample (session.c:12=
11)
=3D=3D22675=3D=3D    by 0x4F61DD: machines__deliver_event (session.c:1248)
=3D=3D22675=3D=3D    by 0x4F66D3: perf_session__deliver_event (session.c:13=
10)
=3D=3D22675=3D=3D    by 0x4F66D3: ordered_events__deliver_event (session.c:=
119)
=3D=3D22675=3D=3D    by 0x4F9CD2: __ordered_events__flush (ordered-events.c=
:210)
=3D=3D22675=3D=3D    by 0x4F9CD2: ordered_events__flush.part.3 (ordered-eve=
nts.c:277)
=3D=3D22675=3D=3D    by 0x4F6DEC: perf_session__process_user_event (session=
=2Ec:1349)
=3D=3D22675=3D=3D    by 0x4F6DEC: perf_session__process_event (session.c:14=
75)
=3D=3D22675=3D=3D    by 0x4F8C5C: __perf_session__process_events (session.c=
:1867)
=3D=3D22675=3D=3D    by 0x4F8C5C: perf_session__process_events (session.c:1=
921)
=3D=3D22675=3D=3D  Address 0xd1fae38 is 24 bytes before a block of size 54 =
alloc'd
=3D=3D22675=3D=3D    at 0x4C2CF35: calloc (in /usr/lib/valgrind/vgpreload_m=
emcheck-
amd64-linux.so)
=3D=3D22675=3D=3D    by 0x4D80F0: symbol__new (symbol.c:240)
=3D=3D22675=3D=3D    by 0x54750E: dso__load_sym (symbol-elf.c:1121)
=3D=3D22675=3D=3D    by 0x4D9D3E: dso__load (symbol.c:1535)
=3D=3D22675=3D=3D    by 0x4F262B: map__load (map.c:292)
=3D=3D22675=3D=3D    by 0x4F262B: map__find_symbol (map.c:335)
=3D=3D22675=3D=3D    by 0x4B3B55: thread__find_addr_location (event.c:1458)
=3D=3D22675=3D=3D    by 0x55BC70: entry (unwind-libunwind-local.c:588)
=3D=3D22675=3D=3D    by 0x55BC70: get_entries (unwind-libunwind-local.c:723)
=3D=3D22675=3D=3D    by 0x55BE01: _unwind__get_entries (unwind-libunwind-lo=
cal.c:745)
=3D=3D22675=3D=3D    by 0x4E8B20: sample__resolve_callchain (callchain.c:10=
16)
=3D=3D22675=3D=3D    by 0x5196F9: hist_entry_iter__add (hist.c:1039)
=3D=3D22675=3D=3D    by 0x448044: process_sample_event (builtin-report.c:20=
4)
=3D=3D22675=3D=3D    by 0x4F61DD: perf_evlist__deliver_sample (session.c:12=
11)
=3D=3D22675=3D=3D    by 0x4F61DD: machines__deliver_event (session.c:1248)
=3D=3D22675=3D=3D=20

Here's the patch that I tried to play around with this concept:

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index a98f55a91cb2..4d1b6e58da00 100644
=2D-- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2037,6 +2037,38 @@ static int unwind_entry(struct unwind_entry *entry,=
=20
void *arg)
=20
        if (symbol_conf.hide_unresolved && entry->sym =3D=3D NULL)
                return 0;
+
+       if (symbol_conf.inline_name && entry->map) {
+               u64 addr =3D map__rip_2objdump(entry->map, entry->ip);
+               struct inline_node *inline_node;
+               inline_node =3D dso__parse_addr_inlines(entry->map->dso, ad=
dr);
+               if (inline_node) {
+                       struct inline_list *ilist;
+                       list_for_each_entry(ilist, &inline_node->val, list)=
 {
+                               struct symbol *sym;
+                               sym =3D dso__find_symbol_by_name(entry->map-
>dso,
+                                                              MAP__FUNCTIO=
N,
+                                                              ilist-
>funcname);
+                               if (!sym) {
+                                       fprintf(stderr, "create new entry\n=
");
+                                       sym =3D symbol__new(entry->sym->sta=
rt,
+                                                         entry->sym->end,
+                                                         entry->sym->bindi=
ng,
+                                                         ilist->funcname);
+                                       dso__insert_symbol(entry->map->dso,
+                                                          MAP__FUNCTION,
+                                                          sym);
+                                       dso__sort_by_name(entry->map->dso,
+                                                         MAP__FUNCTION);
+                                       fprintf(stderr, "%p | %p | %s | %s\=
n",=20
sym,
+                                              =20
dso__find_symbol_by_name(entry->map->dso, MAP__FUNCTION, ilist->funcname),
+                                               sym->name, ilist->funcname);
+                               }
+                               fprintf(stderr, "want to add inline: %s %p\=
n",=20
ilist->funcname, sym);
+                       }
+                       inline_node__delete(inline_node);
+               }
+       }
        return callchain_cursor_append(cursor, entry->ip,
                                       entry->map, entry->sym,
                                       false, NULL, 0, 0);
~~~~~~~~~~~~~~~

Any idea what I'm doing wrong here? Can I not insert into the sorted list?=
=20
I.e. is it not safe to sort multiple times? Is this the wrong approach in=20
general?

Also, any suggestion as to what I'd use for symbol start/end for the inline=
d=20
fake symbols?

Thanks

> > > Also, for the children mode, callchain nodes should have enough
> > > information to create hist entries (but I'm not sure how to apply
> > > self periods for those inlined entries).
> >=20
> > I'm not sure I'm following here either, but once inlined frames are nor=
mal
> > callchain nodes, all browsers will simply support them out of the box, =
no?
> > All of the aggregation and browsing features should just work=E2=84=A2.=
 We'd only
> > need to patch the browsers for special usecases, like when we want to
> > change the visuals to make it clear that a given frame was actually
> > inlined.
>=20
> Yes, once inlined frames converted to callchain cursor nodes, it
> should work out of the box.  But for children mode, it needs a symbol
> to construct a hist entry from a callchain cursor node.  Please see
> fill_callchain_info().  If you add the "(inline)" to the (fake) symbol
> name, you don't even need to patch the browsers IMHO.

Good idea, I'll do that once I get it to work (see above)

Cheers

=2D-=20
Milian Wolff | milian.wolff@kdab.com | Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
--nextPart2499447.09gGyLnWxM
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIUdzCCBGYw
ggNOoAMCAQICEFEmCpMc4n+cw6VfeeByroIwDQYJKoZIhvcNAQEFBQAwgZMxCzAJBgNVBAYTAlVT
MQswCQYDVQQIEwJVVDEXMBUGA1UEBxMOU2FsdCBMYWtlIENpdHkxHjAcBgNVBAoTFVRoZSBVU0VS
VFJVU1QgTmV0d29yazEhMB8GA1UECxMYaHR0cDovL3d3dy51c2VydHJ1c3QuY29tMRswGQYDVQQD
ExJVVE4gLSBEQVRBQ29ycCBTR0MwHhcNMDUwNjA3MDgwOTEwWhcNMTkwNjI0MTkwNjMwWjBvMQsw
CQYDVQQGEwJTRTEUMBIGA1UEChMLQWRkVHJ1c3QgQUIxJjAkBgNVBAsTHUFkZFRydXN0IEV4dGVy
bmFsIFRUUCBOZXR3b3JrMSIwIAYDVQQDExlBZGRUcnVzdCBFeHRlcm5hbCBDQSBSb290MIIBIjAN
BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt/caM+byAAQtOeBOW+0fvGwPzbX6I7bO3psRM5ek
KUx9k5+9SryT7QMa44/P5W1QWtaXKZRagLBJetsulf24yr83OC0ePpFBrXBWx/BPP+gynnTKyJBU
6cZfD3idmkA8Dqxhql4Uj56HoWpQ3NeaTq8Fs6ZxlJxxs1BgCscTnTgHhgKo6ahpJhiQq0ywTyOr
Ok+E2N/On+Fpb7vXQtdrROTHre5tQV9yWnEIN7N5ZaRZoJQ39wAvDcKSctrQOHLbFKhFxF0qfbe0
1sTurM0TRLfJK91DACX6YblpalgjEbenM49WdVn1zSnXRrcKK2W200JvFbK4e/vv6V1T1TRaJwID
AQABo4HYMIHVMB8GA1UdIwQYMBaAFFMy0bPPf/rg8aBdhU6S0p5FHbRPMB0GA1UdDgQWBBStvZh6
NLQm9/rEJlTvA73gJMtUGjAOBgNVHQ8BAf8EBAMCAQYwDwYDVR0TAQH/BAUwAwEB/zARBglghkgB
hvhCAQEEBAMCAQIwIAYDVR0lBBkwFwYKKwYBBAGCNwoDAwYJYIZIAYb4QgQBMD0GA1UdHwQ2MDQw
MqAwoC6GLGh0dHA6Ly9jcmwudXNlcnRydXN0LmNvbS9VVE4tREFUQUNvcnBTR0MuY3JsMA0GCSqG
SIb3DQEBBQUAA4IBAQDG7lMXaBSyUSIekFgNlP298XDlhi3DNjGPVEhG5y0IN7xsCmDhDq1RNOAS
k+m+uKu4JrTplj0oj65kB/7gAezF45HrGKDxdX7bCuafkduvrnXfI5Fo3RcAWkv/ZGxw6wEa0JDZ
x6bWbfYT5P+1ydIeKsuxJUMmeNkwm04NHr5p79/q/i2zzPmw3bUUypHUsrWl+wEZo0d5n52MlYc0
+B84kto2phH6a+tr6dxFeBU5BtdNQeQhyNwvh9G3v0hgdaViyyTeO2GgKSCmvsVsnMTpCmki75E6
+iav0VtBpzri+DgHQqvBW/jObboPBD8yNKzcBCjXcDAUJgbE5JuY1c94MIIEnTCCA4WgAwIBAgIQ
ND3pK6wnNP+PyzSU+8xwVDANBgkqhkiG9w0BAQUFADBvMQswCQYDVQQGEwJTRTEUMBIGA1UEChML
QWRkVHJ1c3QgQUIxJjAkBgNVBAsTHUFkZFRydXN0IEV4dGVybmFsIFRUUCBOZXR3b3JrMSIwIAYD
VQQDExlBZGRUcnVzdCBFeHRlcm5hbCBDQSBSb290MB4XDTA1MDYwNzA4MDkxMFoXDTIwMDUzMDEw
NDgzOFowga4xCzAJBgNVBAYTAlVTMQswCQYDVQQIEwJVVDEXMBUGA1UEBxMOU2FsdCBMYWtlIENp
dHkxHjAcBgNVBAoTFVRoZSBVU0VSVFJVU1QgTmV0d29yazEhMB8GA1UECxMYaHR0cDovL3d3dy51
c2VydHJ1c3QuY29tMTYwNAYDVQQDEy1VVE4tVVNFUkZpcnN0LUNsaWVudCBBdXRoZW50aWNhdGlv
biBhbmQgRW1haWwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCyOYWk8n2rQTtiRjeu
zcFgdbw5ZflKGkeiucxIzGqY1U01GbmkQuXOSeKKLx580jEHx060g2SdLinVomTEhb2FUTV5pE5o
kHsceqSSqBfymBXyk8zJpDKVuwxPML2YoAuL5W4bokb6eLyib6tZXqUvz8rabaov66yhs2qqty5n
NYt54R5piOLmRs2gpeq+C852OnoOm+r82idbPXMfIuZIYcZM82mxqC4bttQxICy8goqOpA6l14lD
/BZarx1x1xFZ2rqHDa/68+HC8KTFZ4zW1lQ63gqkugN3s2XI/R7TdGKqGMpokx6hhX71R2XL+E1X
KHTSNP8wtu72YjAUjCzrAgMBAAGjgfQwgfEwHwYDVR0jBBgwFoAUrb2YejS0Jvf6xCZU7wO94CTL
VBowHQYDVR0OBBYEFImCZ33EnSZwAEu0UEh83j2uBG59MA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMB
Af8EBTADAQH/MBEGA1UdIAQKMAgwBgYEVR0gADBEBgNVHR8EPTA7MDmgN6A1hjNodHRwOi8vY3Js
LnVzZXJ0cnVzdC5jb20vQWRkVHJ1c3RFeHRlcm5hbENBUm9vdC5jcmwwNQYIKwYBBQUHAQEEKTAn
MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0GCSqGSIb3DQEBBQUAA4IB
AQABvJzjYyiw8zEBwt973WKgAZ0jMQ+cknNTUeofTPrWn8TKL2d+eDMPdBa5kYeR9Yom+mRwANge
+QsEYlCHk4HU2vUj2zS7hVa0cDRueIM3HoUcxREVkl+HF72sav3xwtHMiV+xfPA+UfI183zsYJhr
Oivg79+zfYbrtRv1W+yifJgT1wBQudEtc94DeHThBYUxXsuauZ2UxrmUN3Vy3ET7Z+jw+iUeUqfa
JelH4KDHPKBOsQo2+3dIn++Xivu0/uOUFKiDvFwtP9JgcWDuwnGCDOmINuPaILSjoGyqlku4gI51
ykkH9jsUut/cBdmf2+Cy5k2geCbn5y1uf1/GHogVMIIFGjCCBAKgAwIBAgIQbRnqpxlPajMi5iIy
eqpx3jANBgkqhkiG9w0BAQUFADCBrjELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAlVUMRcwFQYDVQQH
Ew5TYWx0IExha2UgQ2l0eTEeMBwGA1UEChMVVGhlIFVTRVJUUlVTVCBOZXR3b3JrMSEwHwYDVQQL
ExhodHRwOi8vd3d3LnVzZXJ0cnVzdC5jb20xNjA0BgNVBAMTLVVUTi1VU0VSRmlyc3QtQ2xpZW50
IEF1dGhlbnRpY2F0aW9uIGFuZCBFbWFpbDAeFw0xMTA0MjgwMDAwMDBaFw0yMDA1MzAxMDQ4Mzha
MIGTMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdT
YWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE5MDcGA1UEAxMwQ09NT0RPIENsaWVu
dCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEAkoSEW0tXmNReL4uk4UDIo1NYX2Zl8TJO958yfVXQeExVt0KU4PkncQfFxmmk
uTLE8UAakMwnVmJ/F7Vxaa7lIBvky2NeYMqiQfZq4aP/uN8fSG1lQ4wqLitjOHffsReswtqCAtbU
MmrUZ28gE49cNfrlVICv2HEKHTcKAlBTbJUdqRAUtJmVWRIx/wmi0kzcUtve4kABW0ho3cVKtODt
JB86r3FfB+OsvxQ7sCVxaD30D9YXWEYVgTxoi4uDD216IVfmNLDbMn7jSuGlUnJkJpFOpZIP/+Cx
YP0ab2hRmWONGoulzEKbm30iY9OpoPzOnpDfRBn0XFs1uhbzp5v/wQIDAQABo4IBSzCCAUcwHwYD
VR0jBBgwFoAUiYJnfcSdJnAAS7RQSHzePa4Ebn0wHQYDVR0OBBYEFHoTTgB0W8Z4Y2QnwS/ioFu8
ecV7MA4GA1UdDwEB/wQEAwIBBjASBgNVHRMBAf8ECDAGAQH/AgEAMBEGA1UdIAQKMAgwBgYEVR0g
ADBYBgNVHR8EUTBPME2gS6BJhkdodHRwOi8vY3JsLnVzZXJ0cnVzdC5jb20vVVROLVVTRVJGaXJz
dC1DbGllbnRBdXRoZW50aWNhdGlvbmFuZEVtYWlsLmNybDB0BggrBgEFBQcBAQRoMGYwPQYIKwYB
BQUHMAKGMWh0dHA6Ly9jcnQudXNlcnRydXN0LmNvbS9VVE5BZGRUcnVzdENsaWVudF9DQS5jcnQw
JQYIKwYBBQUHMAGGGWh0dHA6Ly9vY3NwLnVzZXJ0cnVzdC5jb20wDQYJKoZIhvcNAQEFBQADggEB
AIXWvnhXVW0zf0RS/kLVBqgBA4CK+w2y/Uq/9q9BSfUbWsXSrRtzbj7pJnzmTJjBMCjfy/tCPKEl
Pgp11tA9OYZm0aGbtU2bb68obB2v5ep0WqjascDxdXovnrqTecr+4pEeVnSy+I3T4ENyG+2P/WA5
IEf7i686ZUg8mD2lJb+972DgSeUWyOs/Q4Pw4O4NwdPNM1+b0L1garM7/vrUyTo8H+2b/5tJM75C
KTmD7jNpLoKdRU2oadqAGx490hpdfEeZpZsIbRKZhtZdVwcbpzC+S0lEuJB+ytF5OOu0M/qgOl0m
WJ5hVRi0IdWZ1eBDQEIwvuql55TSsP7zdfl/bucwggZKMIIFMqADAgECAhByCOhbkTwXiJtaa0d5
K5u0MA0GCSqGSIb3DQEBBQUAMIGTMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5j
aGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE5MDcG
A1UEAxMwQ09NT0RPIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4X
DTE0MDYwMjAwMDAwMFoXDTE3MDYwMTIzNTk1OVowggFZMQswCQYDVQQGEwJTRTEPMA0GA1UEERMG
NjgzIDMxMRIwEAYDVQQIEwlWYWVybWxhbmQxEDAOBgNVBAcTB0hhZ2ZvcnMxGDAWBgNVBAkTD05v
cnJpbmdzIHZhZWcgMjEPMA0GA1UEEhMGQm94IDMwMSYwJAYDVQQKDB1LbGFyw6RsdmRhbGVucyBE
YXRha29uc3VsdCBBQjEdMBsGA1UECxMUQSBLREFCIEdyb3VwIENvbXBhbnkxQzBBBgNVBAsMOklz
c3VlZCB0aHJvdWdoIEtsYXLDpGx2ZGFsZW5zIERhdGFrb25zdWx0IEFCIEUtUEtJIE1hbmFnZXIx
HzAdBgNVBAsTFkNvcnBvcmF0ZSBTZWN1cmUgRW1haWwxFTATBgNVBAMTDE1pbGlhbiBXb2xmZjEk
MCIGCSqGSIb3DQEJARYVbWlsaWFuLndvbGZmQGtkYWIuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEAwirYPAOcWQk9jaCoEAn84PwINg/NDs3PxsEd34f27AfCqJepwIF+ikMuBBxt
mm1pieQwU9fcFrE4CXPCdYxfFOdcbJJ58Xzog5aFrJHnYGEFIL8KVvdBvAFeP/AJPaY2lg1JWnVI
1jwO74VmUGMyvMG286wpwW3hWO3sepZZQN3tvXyd9EgD72AiImkvw43+BW4xy8ptOd3TvEwCJ+uN
x8v+uILsRLvKcmSrUsLpo7No2HoifWX1doKHKSwYVVqmOT/rjJWxF98j4w2kTKRsWdQ4ENlqNpjW
zlbtB6TM2mrnInefzALbIoLLQ2E2NFCaMVsczf7RFsMxUepM9KQQ5QIDAQABo4IBzzCCAcswHwYD
VR0jBBgwFoAUehNOAHRbxnhjZCfBL+KgW7x5xXswHQYDVR0OBBYEFGSjHixs9BD9OyGskYjMX7mi
P+fiMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMB0GA1UdJQQWMBQGCCsGAQUFBwMEBggr
BgEFBQcDAjBGBgNVHSAEPzA9MDsGDCsGAQQBsjEBAgEDBTArMCkGCCsGAQUFBwIBFh1odHRwczov
L3NlY3VyZS5jb21vZG8ubmV0L0NQUzBXBgNVHR8EUDBOMEygSqBIhkZodHRwOi8vY3JsLmNvbW9k
b2NhLmNvbS9DT01PRE9DbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWlsQ0EuY3JsMIGI
BggrBgEFBQcBAQR8MHowUgYIKwYBBQUHMAKGRmh0dHA6Ly9jcnQuY29tb2RvY2EuY29tL0NPTU9E
T0NsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcnQwJAYIKwYBBQUHMAGGGGh0
dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTAgBgNVHREEGTAXgRVtaWxpYW4ud29sZmZAa2RhYi5jb20w
DQYJKoZIhvcNAQEFBQADggEBAFvi067uXCOkiUH/D6rv4gV0/e+e8DzcvbbsUxAC5nwDXBv+47ds
l7j8NrZstZraVz35WEWgksNmnyghcuBKzKcN3kY1KNn/ERc9wvns/0dI+yj39L0eSMzchUZoV6GY
MtPfmLofPvUBbDesl97JQXF9vpk8FIVsI1UKKrLzfoKhue5abQHXurSFa0ts1UPmSh2Y8/QCQlFN
lCv8ISyEwVCAkhdIqxRc3hslooBhcRVUrYhRdCLlNN6Od8yuLE9sKWH/K4wg/BpnjCJmGp4GQhU8
DUG2r0CbOa+iZQKTWUgwdGU3Jr+WcOan/JaNzBuKk1GM3D+WcljoU7ZWtoqXPzgxggJaMIICVgIB
ATCBqDCBkzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UE
BxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxOTA3BgNVBAMTMENPTU9ETyBD
bGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQcgjoW5E8F4ibWmtHeSub
tDAJBgUrDgMCGgUAoIGHMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8X
DTE3MDUxNjEzMTgxM1owIwYJKoZIhvcNAQkEMRYEFNQxldhcSS3bFjlYtwZz4ITc6fhMMCgGCSqG
SIb3DQEJDzEbMBkwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA0GCSqGSIb3DQEBAQUABIIBAMCs
obX6SmHQ6uKzF2yGCyJGlgQ62elM4oLPJgIJoXqitfcPYQppbFQWrCL19Dh1YMvWi+VbZr2oDWGu
heVZeK8tVl4h3VfiKZzOx4pdEkw4lYp7/YBHQhaGeS/RAO8UvvT0CePuR+J2DT+fxreaS1EbwlsR
h9DWU+prgNJArAFQo25f9xxZEDpoqlhCV74v916eEB47nE+jEN8vqG1XCv4jW1KJOQTuN23rROFn
uTcVYWArqs9Hq2DFV4m4JAeKzSmvdQ9fyXeGflj9uQ2krk6gc/2ThBKg2cUoumCOd5Jfu5rpWKS5
JmWfwnZpd586g9s1FKurseQncXLIqQRmKJoAAAAAAAA=


--nextPart2499447.09gGyLnWxM--
