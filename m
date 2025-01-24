Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4574D1D8E16;
	Fri, 24 Jan 2025 06:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737700169; cv=none; b=jvP8wJn6FoMwxtYemBCAJIKwIbVj2ek6PuTnIH4J1M3gDff4SUoA+Tr9J122JAtoiuAxz6sYMQFQHUL5D2+VllOd7wnv2JzjcO87tfkbYbfGj+fGOEJkRIA84GvZ4xlsjRh+vj7GSiIo0dBCDBvnpSm4ohCQ6xrQpYPbNPeJgEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737700169; c=relaxed/simple;
	bh=0jEdiGwJgRwp6u6IBZhNTqy07cqDTldJv1fgreLYsEQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iDxkkUz7zKJxF6zHc8LpTa5HRlt8k6q9lWcOA4p1c4++LmLgcXhB5ohDssbVpLqd+O8+NV1ZNuIKz6UIlSLDzTgZozs45txvBu8MI+wnbEKST6Z63ao1oFZEvnHqU9eCsIS9NbL3celDPIk145WiWcK5SPjL54cIrAZQncnpbEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from unicom145.biz-email.net
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id VXB00115;
        Fri, 24 Jan 2025 14:29:15 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 jtjnmail201611.home.langchao.com (10.100.2.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 24 Jan 2025 14:29:14 +0800
Received: from jtjnmail201607.home.langchao.com ([fe80::c5ea:abc2:7a50:1de9])
 by jtjnmail201607.home.langchao.com ([fe80::c5ea:abc2:7a50:1de9%8]) with mapi
 id 15.01.2507.039; Fri, 24 Jan 2025 14:29:14 +0800
From: =?utf-8?B?Q2hhcmxlcyBIYW4o6Z+p5pil6LaFKQ==?= <hanchunchao@inspur.com>
To: "irogers@google.com" <irogers@google.com>, "edward.baker@intel.com"
	<edward.baker@intel.com>
CC: "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "acme@kernel.org" <acme@kernel.org>,
	"namhyung@kernel.org" <namhyung@kernel.org>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "alexander.shishkin@linux.intel.com"
	<alexander.shishkin@linux.intel.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIHBlcmYgdmVuZG9yIGV2ZW50czogRml4IGRvdWJs?=
 =?utf-8?Q?e_word_in_BriefDescription?=
Thread-Topic: [PATCH] perf vendor events: Fix double word in BriefDescription
Thread-Index: AQHbbhPDln6+ykkgo0ac8t7S6UELXrMkyqAAgACqylA=
Date: Fri, 24 Jan 2025 06:29:13 +0000
Message-ID: <8d7019038b4e4448960233855c28d5e8@inspur.com>
References: <a86efa823973af905ad349aeba28b3b024-1-25google.com@sslemail.net>
 <CAP-5=fXY8a1yv7DpYPcZ+TeO+_sxv0MNyh3RVMav2JEGyiCn1w@mail.gmail.com>
In-Reply-To: <CAP-5=fXY8a1yv7DpYPcZ+TeO+_sxv0MNyh3RVMav2JEGyiCn1w@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=SHA1; boundary="----=_NextPart_000_0027_01DB6E6C.56600BE0"
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
tUid: 20251241429158555bc13fbdac5cf9419ea0093684664
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

------=_NextPart_000_0027_01DB6E6C.56600BE0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi=EF=BC=8C
I created a pull request   fix it  on  github.

Best,
Charles=20

-----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
=E5=8F=91=E4=BB=B6=E4=BA=BA: Ian Rogers <irogers@google.com>=20
=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B41=E6=9C=8824=E6=97=A5 =
12:14
=E6=94=B6=E4=BB=B6=E4=BA=BA: Charles Han(=E9=9F=A9=E6=98=A5=E8=B6=85) =
<hanchunchao@inspur.com>; Edward <edward.baker@intel.com>
=E6=8A=84=E9=80=81: peterz@infradead.org; mingo@redhat.com; =
acme@kernel.org; namhyung@kernel.org; mark.rutland@arm.com; =
alexander.shishkin@linux.intel.com; jolsa@kernel.org; =
adrian.hunter@intel.com; kan.liang@linux.intel.com; =
linux-perf-users@vger.kernel.org; linux-kernel@vger.kernel.org
=E4=B8=BB=E9=A2=98: Re: [PATCH] perf vendor events: Fix double word in =
BriefDescription

On Thu, Jan 23, 2025 at 7:55=E2=80=AFPM Charles Han =
<hanchunchao@inspur.com> wrote:
>
> Remove the repeated word "for" in BriefDescription.
>
> Signed-off-by: Charles Han <hanchunchao@inspur.com>

Hi,

Thanks for the contribution and reporting the issue! These files are =
generated by the script here:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
In the input json files I see the same error:
https://github.com/intel/perfmon/blob/main/GNR/events/graniterapids_uncor=
e_experimental.json#L7524
Ed could you address this or should Charles send a fix to github?

Thanks,
Ian

> ---
>  .../graniterapids/uncore-interconnect.json    | 36 =
+++++++++----------
>  1 file changed, 18 insertions(+), 18 deletions(-)
>
> diff --git=20
> a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-interconnect.jso
> n=20
> b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-interconnect.jso
> n index 856ee985ecd4..0f5332ad0b80 100644
> ---=20
> a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-interconnect.jso
> n
> +++ b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-interconnect
> +++ .json
> @@ -1016,7 +1016,7 @@
>          "Unit": "MDF"
>      },
>      {
> -        "BriefDescription": "Egress bypasses for for AD_BNC",
> +        "BriefDescription": "Egress bypasses for AD_BNC",
>          "Counter": "0,1,2,3",
>          "EventCode": "0x1E",
>          "EventName": "UNC_MDF_TxR_BYPASS.AD_BNC", @@ -1026,7 +1026,7=20
> @@
>          "Unit": "MDF"
>      },
>      {
> -        "BriefDescription": "Egress bypasses for for AD_CRD",
> +        "BriefDescription": "Egress bypasses for AD_CRD",
>          "Counter": "0,1,2,3",
>          "EventCode": "0x1E",
>          "EventName": "UNC_MDF_TxR_BYPASS.AD_CRD", @@ -1036,7 +1036,7=20
> @@
>          "Unit": "MDF"
>      },
>      {
> -        "BriefDescription": "Egress bypasses for for AK",
> +        "BriefDescription": "Egress bypasses for AK",
>          "Counter": "0,1,2,3",
>          "EventCode": "0x1E",
>          "EventName": "UNC_MDF_TxR_BYPASS.AK", @@ -1046,7 +1046,7 @@
>          "Unit": "MDF"
>      },
>      {
> -        "BriefDescription": "Egress bypasses for for BL_BNC",
> +        "BriefDescription": "Egress bypasses for BL_BNC",
>          "Counter": "0,1,2,3",
>          "EventCode": "0x1E",
>          "EventName": "UNC_MDF_TxR_BYPASS.BL_BNC", @@ -1056,7 +1056,7=20
> @@
>          "Unit": "MDF"
>      },
>      {
> -        "BriefDescription": "Egress bypasses for for BL_CRD",
> +        "BriefDescription": "Egress bypasses for BL_CRD",
>          "Counter": "0,1,2,3",
>          "EventCode": "0x1E",
>          "EventName": "UNC_MDF_TxR_BYPASS.BL_CRD", @@ -1066,7 +1066,7=20
> @@
>          "Unit": "MDF"
>      },
>      {
> -        "BriefDescription": "Egress bypasses for for IV",
> +        "BriefDescription": "Egress bypasses for IV",
>          "Counter": "0,1,2,3",
>          "EventCode": "0x1E",
>          "EventName": "UNC_MDF_TxR_BYPASS.IV", @@ -1076,7 +1076,7 @@
>          "Unit": "MDF"
>      },
>      {
> -        "BriefDescription": "Number of egress inserts for for =
AD_BNC",
> +        "BriefDescription": "Number of egress inserts for AD_BNC",
>          "Counter": "0,1,2,3",
>          "EventCode": "0x1C",
>          "EventName": "UNC_MDF_TxR_INSERTS.AD_BNC", @@ -1086,7 +1086,7 =

> @@
>          "Unit": "MDF"
>      },
>      {
> -        "BriefDescription": "Number of egress inserts for for =
AD_CRD",
> +        "BriefDescription": "Number of egress inserts for AD_CRD",
>          "Counter": "0,1,2,3",
>          "EventCode": "0x1C",
>          "EventName": "UNC_MDF_TxR_INSERTS.AD_CRD", @@ -1096,7 +1096,7 =

> @@
>          "Unit": "MDF"
>      },
>      {
> -        "BriefDescription": "Number of egress inserts for for AK",
> +        "BriefDescription": "Number of egress inserts for AK",
>          "Counter": "0,1,2,3",
>          "EventCode": "0x1C",
>          "EventName": "UNC_MDF_TxR_INSERTS.AK", @@ -1106,7 +1106,7 @@
>          "Unit": "MDF"
>      },
>      {
> -        "BriefDescription": "Number of egress inserts for for =
BL_BNC",
> +        "BriefDescription": "Number of egress inserts for BL_BNC",
>          "Counter": "0,1,2,3",
>          "EventCode": "0x1C",
>          "EventName": "UNC_MDF_TxR_INSERTS.BL_BNC", @@ -1116,7 +1116,7 =

> @@
>          "Unit": "MDF"
>      },
>      {
> -        "BriefDescription": "Number of egress inserts for for =
BL_CRD",
> +        "BriefDescription": "Number of egress inserts for BL_CRD",
>          "Counter": "0,1,2,3",
>          "EventCode": "0x1C",
>          "EventName": "UNC_MDF_TxR_INSERTS.BL_CRD", @@ -1126,7 +1126,7 =

> @@
>          "Unit": "MDF"
>      },
>      {
> -        "BriefDescription": "Number of egress inserts for for IV",
> +        "BriefDescription": "Number of egress inserts for IV",
>          "Counter": "0,1,2,3",
>          "EventCode": "0x1C",
>          "EventName": "UNC_MDF_TxR_INSERTS.IV", @@ -1136,7 +1136,7 @@
>          "Unit": "MDF"
>      },
>      {
> -        "BriefDescription": "Egress occupancy for for AD_BNC",
> +        "BriefDescription": "Egress occupancy for AD_BNC",
>          "Counter": "0,1,2,3",
>          "EventCode": "0x1D",
>          "EventName": "UNC_MDF_TxR_OCCUPANCY.AD_BNC", @@ -1146,7=20
> +1146,7 @@
>          "Unit": "MDF"
>      },
>      {
> -        "BriefDescription": "Egress occupancy for for AD_CRD",
> +        "BriefDescription": "Egress occupancy for AD_CRD",
>          "Counter": "0,1,2,3",
>          "EventCode": "0x1D",
>          "EventName": "UNC_MDF_TxR_OCCUPANCY.AD_CRD", @@ -1156,7=20
> +1156,7 @@
>          "Unit": "MDF"
>      },
>      {
> -        "BriefDescription": "Egress occupancy for for AK",
> +        "BriefDescription": "Egress occupancy for AK",
>          "Counter": "0,1,2,3",
>          "EventCode": "0x1D",
>          "EventName": "UNC_MDF_TxR_OCCUPANCY.AK", @@ -1166,7 +1166,7=20
> @@
>          "Unit": "MDF"
>      },
>      {
> -        "BriefDescription": "Egress occupancy for for BL_BNC",
> +        "BriefDescription": "Egress occupancy for BL_BNC",
>          "Counter": "0,1,2,3",
>          "EventCode": "0x1D",
>          "EventName": "UNC_MDF_TxR_OCCUPANCY.BL_BNC", @@ -1176,7=20
> +1176,7 @@
>          "Unit": "MDF"
>      },
>      {
> -        "BriefDescription": "Egress occupancy for for BL_CRD",
> +        "BriefDescription": "Egress occupancy for BL_CRD",
>          "Counter": "0,1,2,3",
>          "EventCode": "0x1D",
>          "EventName": "UNC_MDF_TxR_OCCUPANCY.BL_CRD", @@ -1186,7=20
> +1186,7 @@
>          "Unit": "MDF"
>      },
>      {
> -        "BriefDescription": "Egress occupancy for for IV",
> +        "BriefDescription": "Egress occupancy for IV",
>          "Counter": "0,1,2,3",
>          "EventCode": "0x1D",
>          "EventName": "UNC_MDF_TxR_OCCUPANCY.IV",
> --
> 2.31.1
>

------=_NextPart_000_0027_01DB6E6C.56600BE0
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIILJTCCA8kw
ggKxoAMCAQICEHiR8OF3G5iSSYrK6OtgewAwDQYJKoZIhvcNAQELBQAwWTETMBEGCgmSJomT8ixk
ARkWA2NvbTEYMBYGCgmSJomT8ixkARkWCGxhbmdjaGFvMRQwEgYKCZImiZPyLGQBGRYEaG9tZTES
MBAGA1UEAxMJSU5TUFVSLUNBMB4XDTE3MDEwOTA5MjgzMFoXDTM0MDUxMTEyMjAwNFowWTETMBEG
CgmSJomT8ixkARkWA2NvbTEYMBYGCgmSJomT8ixkARkWCGxhbmdjaGFvMRQwEgYKCZImiZPyLGQB
GRYEaG9tZTESMBAGA1UEAxMJSU5TUFVSLUNBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAq+Q17xtjJLyp5hgXDie1r4DeNj76VUvbZNSywWU5zhx+e0Lu0kwcZ0T3KncZdgdWyqYvRJMQ
/VVqX3gS4VxtLw3zBrg9kGuD0LfpH0cA2b0ZHpxRh5WapP14flcSh/lnawig29z44wfUEg43yTZO
lOfPKos/Dm6wyrJtaPmD6AF7w4+vFZH0zMYfjQkSN/xGgS3OPBNAB8PTHM2sV+fFmnnlTFpyRg0O
IIA2foALZvjIjNdUfp8kMGSh/ZVMfHqTH4eo+FcZPZ+t9nTaJQz9cSylw36+Ig6FGZHA/Zq+0fYy
VCxR1ZLULGS6wsVep8j075zlSinrVpMadguOcArThwIDAQABo4GMMIGJMBMGCSsGAQQBgjcUAgQG
HgQAQwBBMAsGA1UdDwQEAwIBhjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBReWQOmtExYYJFO
9h61pTmmMsE1ajAQBgkrBgEEAYI3FQEEAwIBATAjBgkrBgEEAYI3FQIEFgQUJmGwrST2eo+dKLZv
FQ4PiIOniEswDQYJKoZIhvcNAQELBQADggEBAIhkYRbyElnZftcS7NdO0TO0y2wCULFpAyG//cXy
rXPdTLpQO0k0aAy42P6hTLbkpkrq4LfVOhcx4EWC1XOuORBV2zo4jk1oFnvEsuy6H4a8o7favPPX
90Nfvmhvz/rGy4lZTSZV2LONmT85D+rocrfsCGdQX/dtxx0jWdYDcO53MLq5qzCFiyQRcLNqum66
pa8v1OSs99oKptY1dR7+GFHdA7Zokih5tugQbm7jJR+JRSyf+PomWuIiZEvYs+NpNVac+gyDUDkZ
sb0vHPENGwf1a9gElQa+c+EHfy9Y8O+7Ha8IpLWUArNP980tBvO/TYYU6LMz07h7RyiXqr7fvEcw
ggdUMIIGPKADAgECAhN+AAC/VCtcoMk3ynmeAAAAAL9UMA0GCSqGSIb3DQEBCwUAMFkxEzARBgoJ
kiaJk/IsZAEZFgNjb20xGDAWBgoJkiaJk/IsZAEZFghsYW5nY2hhbzEUMBIGCgmSJomT8ixkARkW
BGhvbWUxEjAQBgNVBAMTCUlOU1BVUi1DQTAeFw0yMDA1MDkwMDM4MzJaFw0yNTA1MDgwMDM4MzJa
MIGoMRMwEQYKCZImiZPyLGQBGRYDY29tMRgwFgYKCZImiZPyLGQBGRYIbGFuZ2NoYW8xFDASBgoJ
kiaJk/IsZAEZFgRob21lMRUwEwYDVQQLDAzmtarmva7kv6Hmga8xDzANBgNVBAsMBueUqOaItzES
MBAGA1UEAwwJ6Z+p5pil6LaFMSUwIwYJKoZIhvcNAQkBFhZoYW5jaHVuY2hhb0BpbnNwdXIuY29t
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAzm0yCuz4EQ3xxu11MjZDvWhjKBqOXHQq
WMG9kcf6SW0yQXtyQCGGputXc8oJ/n7XIfs96MZcphiKzLhIFkjkyvqlsCX6GqkcBd/98tDoIbq+
WDvPOrEYi/Sxsyh1Z9Ewn8EjK6jhBHCXq5FBgbxGjZLsHOYlWNrU17jSmPBszSTXXAMBrPTKpgHq
mWlZVDIuggE1ob3cZhymT8U8gQTES1sf0DzgHVXjLle1XZia/K/1Pa/W11Lh83GAmzmhqw5hCmPb
7zGmZCkjSjV0qVa/Q8OWjCAa23lLrEy8M/kZDroI1KubkC1fDdOO3NF1EpJx4oG4nnWJdsIf1vA8
rcS4fQIDAQABo4IDwzCCA78wPQYJKwYBBAGCNxUHBDAwLgYmKwYBBAGCNxUIgvKpH4SB13qGqZE9
hoD3FYPYj1yBSv2LJoGUp00CAWQCAWAwKQYDVR0lBCIwIAYIKwYBBQUHAwIGCCsGAQUFBwMEBgor
BgEEAYI3CgMEMAsGA1UdDwQEAwIFoDA1BgkrBgEEAYI3FQoEKDAmMAoGCCsGAQUFBwMCMAoGCCsG
AQUFBwMEMAwGCisGAQQBgjcKAwQwRAYJKoZIhvcNAQkPBDcwNTAOBggqhkiG9w0DAgICAIAwDgYI
KoZIhvcNAwQCAgCAMAcGBSsOAwIHMAoGCCqGSIb3DQMHMB0GA1UdDgQWBBT7zLhcTtRnG/DUzvnf
bTyU6LH+GjAfBgNVHSMEGDAWgBReWQOmtExYYJFO9h61pTmmMsE1ajCCAQ8GA1UdHwSCAQYwggEC
MIH/oIH8oIH5hoG6bGRhcDovLy9DTj1JTlNQVVItQ0EsQ049SlRDQTIwMTIsQ049Q0RQLENOPVB1
YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9aG9t
ZSxEQz1sYW5nY2hhbyxEQz1jb20/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9iYXNlP29iamVj
dENsYXNzPWNSTERpc3RyaWJ1dGlvblBvaW50hjpodHRwOi8vSlRDQTIwMTIuaG9tZS5sYW5nY2hh
by5jb20vQ2VydEVucm9sbC9JTlNQVVItQ0EuY3JsMIIBKQYIKwYBBQUHAQEEggEbMIIBFzCBsQYI
KwYBBQUHMAKGgaRsZGFwOi8vL0NOPUlOU1BVUi1DQSxDTj1BSUEsQ049UHVibGljJTIwS2V5JTIw
U2VydmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1ob21lLERDPWxhbmdjaGFv
LERDPWNvbT9jQUNlcnRpZmljYXRlP2Jhc2U/b2JqZWN0Q2xhc3M9Y2VydGlmaWNhdGlvbkF1dGhv
cml0eTBhBggrBgEFBQcwAoZVaHR0cDovL0pUQ0EyMDEyLmhvbWUubGFuZ2NoYW8uY29tL0NlcnRF
bnJvbGwvSlRDQTIwMTIuaG9tZS5sYW5nY2hhby5jb21fSU5TUFVSLUNBLmNydDBJBgNVHREEQjBA
oCYGCisGAQQBgjcUAgOgGAwWaGFuY2h1bmNoYW9AaW5zcHVyLmNvbYEWaGFuY2h1bmNoYW9AaW5z
cHVyLmNvbTANBgkqhkiG9w0BAQsFAAOCAQEAMkzghq4SHO2Fi0jhZ+VOCkTi/CTHr498pTYAVLS0
sn5HIh5mWwendN0n32AyOhH6rsbFvddJ0fpH3B86HtXSc20xlnq902GTXbW//53nIGrZ4h/JQvyd
rEd/LXg7eg2MnGwRkF5+4FgA49bazD0rNDgrEWmJxZKw8AKtAbdPwxy1Ht1SnxmzK00VSG2z3SgI
0Jm9SSBrytasx8AtE28UXL3uda2/agWd7LsHcApmqPBkdBxS4WotiWyEJfYbU4KQhdSB+v8utqmB
akOC+gFarxuIilfCjNjh0b9jlTgRo5/vG6kpCUBiy1yiOQ9rTi6NjGzDfVCBJ745tySGx7xZYDGC
A5MwggOPAgEBMHAwWTETMBEGCgmSJomT8ixkARkWA2NvbTEYMBYGCgmSJomT8ixkARkWCGxhbmdj
aGFvMRQwEgYKCZImiZPyLGQBGRYEaG9tZTESMBAGA1UEAxMJSU5TUFVSLUNBAhN+AAC/VCtcoMk3
ynmeAAAAAL9UMAkGBSsOAwIaBQCgggH4MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI1MDEyNDA2MjkxMlowIwYJKoZIhvcNAQkEMRYEFM4zxmNDYSQ1fAEHBCNXYsZG
dzhXMH8GCSsGAQQBgjcQBDFyMHAwWTETMBEGCgmSJomT8ixkARkWA2NvbTEYMBYGCgmSJomT8ixk
ARkWCGxhbmdjaGFvMRQwEgYKCZImiZPyLGQBGRYEaG9tZTESMBAGA1UEAxMJSU5TUFVSLUNBAhN+
AAC/VCtcoMk3ynmeAAAAAL9UMIGBBgsqhkiG9w0BCRACCzFyoHAwWTETMBEGCgmSJomT8ixkARkW
A2NvbTEYMBYGCgmSJomT8ixkARkWCGxhbmdjaGFvMRQwEgYKCZImiZPyLGQBGRYEaG9tZTESMBAG
A1UEAxMJSU5TUFVSLUNBAhN+AAC/VCtcoMk3ynmeAAAAAL9UMIGTBgkqhkiG9w0BCQ8xgYUwgYIw
CwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjAKBggqhkiG9w0DBzALBglghkgBZQMEAQIwDgYIKoZI
hvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIaMAsGCWCGSAFlAwQCAzALBglghkgBZQME
AgIwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAGDCAqFH2N+h25CNplvgRCy2jNgQzrO6
Vcb758YxwPYQ3hVFVhMN6vtlVNur30XHwOlZZiFUNnDIUPquRbxnnBO5YXfKXmMEjWBryCmP/aqd
hR/k0DNz4gr2CQXDrLoPWLJJ07WUssIWvza5PvURLYEy32r0kPM/uSrC7TyKqs2OdNAJhmVmC2fI
dpCDGqklsb6NTTfrW+oKt4ilO+fLYToz+C62LdiKIf8QG8jYkds4voK6yP1GWyHcAG578gTwXrpX
babw2FXuwW92BB50nQjjRkMN3CSNf+WiR5nHXRSrikN7YiFlg5JQ2RI0tcdIHHsJfykgtGrbMDBr
oLX0b7kAAAAAAAA=

------=_NextPart_000_0027_01DB6E6C.56600BE0--
