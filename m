From: Jack Henschel <jackdev@mailbox.org>
Subject: Re: Filter option should follow a tracer option
Date: Thu, 24 Aug 2017 10:36:55 +0200
Message-ID: <673dd554-4718-20bf-5a76-38f27f3f5290@mailbox.org>
References: <2141818167.39420.1503049431846@office.mailbox.org>
 <20170822190011.GA31893@kernel.org>
 <a214874a-a271-729e-d253-731e648a10e6@intel.com>
 <98754540.17249.1503478275998@office.mailbox.org>
 <de75121e-cafc-0389-039b-fb038e0ff7c6@intel.com>
 <301454280.19507.1503490276770@office.mailbox.org>
 <20170823132251.GB31893@kernel.org>
 <f142538f-b403-2f15-5dbe-f2d2b07ab777@mailbox.org>
 <20170823190757.GA10477@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="R1LvGn44KSTXRpbVEbX9IVl5mid6mffl1"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:51643 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751796AbdHXIhD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 24 Aug 2017 04:37:03 -0400
In-Reply-To: <20170823190757.GA10477@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--R1LvGn44KSTXRpbVEbX9IVl5mid6mffl1
Content-Type: multipart/mixed; boundary="hRtVEq7MbHpB2qLoliJn9CNS1IXdhd7xh";
 protected-headers="v1"
From: Jack Henschel <jackdev@mailbox.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org
Message-ID: <673dd554-4718-20bf-5a76-38f27f3f5290@mailbox.org>
Subject: Re: Filter option should follow a tracer option
References: <2141818167.39420.1503049431846@office.mailbox.org>
 <20170822190011.GA31893@kernel.org>
 <a214874a-a271-729e-d253-731e648a10e6@intel.com>
 <98754540.17249.1503478275998@office.mailbox.org>
 <de75121e-cafc-0389-039b-fb038e0ff7c6@intel.com>
 <301454280.19507.1503490276770@office.mailbox.org>
 <20170823132251.GB31893@kernel.org>
 <f142538f-b403-2f15-5dbe-f2d2b07ab777@mailbox.org>
 <20170823190757.GA10477@kernel.org>
In-Reply-To: <20170823190757.GA10477@kernel.org>

--hRtVEq7MbHpB2qLoliJn9CNS1IXdhd7xh
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 08/23/2017 09:07 PM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Aug 23, 2017 at 03:40:41PM +0200, Jack Henschel escreveu:
>> On 08/23/2017 03:22 PM, Arnaldo Carvalho de Melo wrote:
>>> Em Wed, Aug 23, 2017 at 02:11:16PM +0200, Jack Henschel escreveu:
>>>>> Adrian Hunter <adrian.hunter@intel.com> hat am 23. August 2017 um 1=
2:33 geschrieben:
>>>>> On 23/08/17 11:51, Jack Henschel wrote:
>>>>>>> Adrian Hunter <adrian.hunter@intel.com> hat am 23. August 2017 um=
 08:06 geschrieben:
>>>>>>> On 22/08/17 22:00, Arnaldo Carvalho de Melo wrote:
>>>>>>>> Em Fri, Aug 18, 2017 at 11:43:51AM +0200, Jack Henschel escreveu=
:
>>>>>>>>> I'm using perf version 4.9.30 with kernel 4.9.30-2+deb9u3 on De=
bian 9 Stretch.
>>>
>>>>>>> It looks like either your CPU does not support Intel PT at all, o=
r it does not support address filtering.
>>>
>>>>>> My CPU (Xeon CPU E5-2680 v4) supports Intel PT (intel_pt flag is
>>>>>> present in /proc/cpuinfo), but this is not an issue with Intel PT.=

>>>>>> Here are some more examples (with various syntaxes):
>>>
>>>>> I think that is Broadwell which doesn't have address filtering.
>>>> Indeed, it is Broadwell.
>>> =20
>>>>>>> Have you checked the value of /sys/bus/event_source/devices/intel=
_pt/nr_addr_filters ?
>>>>>> I don't have that file:
>>>>>
>>>>> Which definitely means address filtering is not supported.  That is=

>>>>> mentioned in the man page for 'perf record'.
>>>
>>>> Ok, thanks for the clarification. It is mentioned in the perf record=

>>>> man-page, but the perf error message could be a little bit more
>>>> specific for this issue. (e.g.
>>>> /sys/bus/event_source/devices/intel_pt/nr_addr_filters not present -=
>
>>>> "CPU does not support address filtering").
>>>
>>> Right, I'll get that into some __strerror() function. Will CC you whe=
n
>>> that is done.
>>>
>>> E.g. __strerror() function: perf_evsel__open_strerror(), that helps t=
he
>>> user wrt errors returned by the perf_evsel__open() function:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/t=
ools/perf/util/evsel.c?h=3Dperf/core#n2669
>>
>> Hi,
>>
>> I just hacked together a quick patch for this, too :-)
>>
>> Since you are=20
>> a) the maintainer of affected files (as I have just found out with the=
 get_maintainer.pl script)=20
>> and=20
>> b) this is my first kernel patch
>> maybe you can give me some feedback on it. I did my best to follow all=
 kernel coding and contributing guidelines.
>=20
> Ok, thank you in advance.
>=20
> Even in these cases, its always good to CC the development mailing list=
,
> which in this case is linux-kernel@vger.kernel.org, because even I'm
> being the maintainer of tools/perf/ in general there are areas where
> other people, like Jiri Olsa, here CCed have more experience or are the=

> primary authors.
Ok, thanks for the hint. :-)

> Having said that, from a quick look, I was expecting a even more precis=
e
> explanation, one tied to intel PT, where that file Adrian pointed out,
> would have its existence checked
> (/sys/bus/event_source/devices/intel_pt/nr_addr_filters).
I would have made the error message more explicit, but as far as I can se=
e this does not necessarily have anything to with intel_pt (other hardwar=
e such as Intel RTIT may provide address filtering, too):

set_filter (util/parse-events.c) calls perf_pmu__scan to find available P=
MUs.=20
perf_pmu__scan (util/pmu.c) is in this case (pmu =3D=3D NULL) just a wrap=
per over pmu_read_sysfs.
pmu_read_sysfs (util/pmu.c) in turn just reads all available entries from=
 EVENT_SOURCE_DEVICE_PATH (/sys/bus/event_source/devices/).

=3D> Not necessarily Intel PT specific.

> Because people that know that their CPU has Intel PT, say having a
> broadwell, like you, would maybe think that they could use hw filters,
> when only some later chips have that feature.
>=20
> Adrian, is this something that started from some specific revision that=

> we could point out in the message?

I spent yesterdays afternoon digging through the Intel Webpage to find ou=
t which chips / micro-architecture supports which feature, but so far the=
 only real resource I have found is Andi Kleen's blog post on Intel PT:

CPU 	                                    Support
Broadwell (5th generation Core, Xeon v4)    More overhead. No fine graine=
d timing.
Skylake (6th generation Core, Xeon v5) 	    Fine grained timing. Address =
filtering.
Goldmont (Apollo Lake, Denverton) 	    Fine grained timing. Address filte=
ring.

http://halobates.de/blog/p/410

Greetings
Jack


> - Arnaldo
> =20
>> (see attached)
>>
>> Greetings
>> Jack
>=20
>> From 3143fb373b16eb6e8f674cca7127801e2809e4c0 Mon Sep 17 00:00:00 2001=

>> From: Jack Henschel <jackdev@mailbox.org>
>> Date: Wed, 23 Aug 2017 15:20:40 +0200
>> Subject: [PATCH] perf events parse: Improve error message for address =
filters
>>
>> This patch improves the error message of the perf events parser
>> when the hardware does not support address filters.
>>
>> Previously, the perf returned the following error:
>>> --filter option should follow a -e tracepoint or HW tracer option
>> This implies there is some syntax error present in the command line,
>> which is not true. Rather, notify the user that the CPU does not have
>> support for this feature.
>>
>> Signed-off-by: Jack Henschel <jackdev@mailbox.org>
>> ---
>>  tools/perf/util/parse-events.c | 20 ++++++++++----------
>>  1 file changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-ev=
ents.c
>> index 01e779b91c8e..7f9e3906fb81 100644
>> --- a/tools/perf/util/parse-events.c
>> +++ b/tools/perf/util/parse-events.c
>> @@ -1833,8 +1833,11 @@ static int set_filter(struct perf_evsel *evsel,=
 const void *arg)
>>  	int nr_addr_filters =3D 0;
>>  	struct perf_pmu *pmu =3D NULL;
>> =20
>> -	if (evsel =3D=3D NULL)
>> -		goto err;
>> +	if (evsel =3D=3D NULL) {
>> +		fprintf(stderr,
>> +			"--filter option should follow a -e tracepoint or HW tracer option=
\n");
>> +		return -1;
>> +	}
>> =20
>>  	if (evsel->attr.type =3D=3D PERF_TYPE_TRACEPOINT) {
>>  		if (perf_evsel__append_tp_filter(evsel, str) < 0) {
>> @@ -1856,8 +1859,11 @@ static int set_filter(struct perf_evsel *evsel,=
 const void *arg)
>>  		perf_pmu__scan_file(pmu, "nr_addr_filters",
>>  				    "%d", &nr_addr_filters);
>> =20
>> -	if (!nr_addr_filters)
>> -		goto err;
>> +	if (!nr_addr_filters) {
>> +		fprintf(stderr,
>> +			"This CPU does not support address filtering\n");
>> +		return -1;
>> +	}
>> =20
>>  	if (perf_evsel__append_addr_filter(evsel, str) < 0) {
>>  		fprintf(stderr,
>> @@ -1866,12 +1872,6 @@ static int set_filter(struct perf_evsel *evsel,=
 const void *arg)
>>  	}
>> =20
>>  	return 0;
>> -
>> -err:
>> -	fprintf(stderr,
>> -		"--filter option should follow a -e tracepoint or HW tracer option\=
n");
>> -
>> -	return -1;
>>  }
>> =20
>>  int parse_filter(const struct option *opt, const char *str,
>> --=20
>> 2.14.1
>>
>=20
>=20
>=20
>=20


--hRtVEq7MbHpB2qLoliJn9CNS1IXdhd7xh--

--R1LvGn44KSTXRpbVEbX9IVl5mid6mffl1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJIBAEBCAAyFiEE5SNfW5QVort2C78YV5HQ+s4K8DwFAlmekCgUHGphY2tkZXZA
bWFpbGJveC5vcmcACgkQV5HQ+s4K8DxxxA/7BuDuIHZm+KSx3qu86RFQZ8h54GAb
kQs0DBG8zojdMzNeDZxGoIQIzWfwg+X0GvshI00lbsebryr+gu4myYQS/fvEOlo2
O8mhUIQm6cNoMW2og08rSnMC1FCPJmiUOeiHZIaVvbB0K7YzgadSDX8Zwi1KFjou
Iorkt+ykWA4zNAlNyYISoiEP58EsBzy9XsaIPeTMgpfFPePkh1sS2XxLpy6Ko6iE
QZdQn/V30JlcBFNL6hDMBgngT2YzqTKgAjwmqymKZJDRLEF1PvElJqbwG6Hu57/+
r+VC9E78OIXnoYd/2+AxFoyX5UDJW/Anb1LwOtdSaYo6f9x97QJCZn1LsYu4ISlz
PJDOewJHcxd3s0yNPPvx2u3iUlX6yprWx19BlbTY+A1I9j7PkhV/gr1hhUVRtzJx
jSg4MhNpaUJhJXInSWher0EafDJkjISDKtcfHOxNRFa+2gm1EHGe6amnlv5skke4
uOgrxl+gZbwoOpykUGabrCk6aY+WzdwWt7J/n6Ymb0dhvlJffrMvo1trKyDY/5ac
OSQNCaM49/0l54TEYgN1kTyVBqtieLI+HrliiluJ5Jxx8o9vvpKyg6kcdtIYSrVI
OZ8QhewKStlMvQNqBFLJztFfMDNajvHX43iCZLaX8vpFJBPovTJZaAQgWZxYa0Ix
lKjCIx8EK3uEWcI=
=aMoT
-----END PGP SIGNATURE-----

--R1LvGn44KSTXRpbVEbX9IVl5mid6mffl1--
