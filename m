Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BEA2E65A
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Oct 2023 15:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9059A13C8B
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Oct 2023 08:45:35 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-79-v8EnXri1O82uYGWoVdPKWQ-1; Thu, 05 Oct 2023 16:45:32 +0100
X-MC-Unique: v8EnXri1O82uYGWoVdPKWQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 5 Oct
 2023 16:45:31 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 5 Oct 2023 16:45:30 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Athira Rajeev' <atrajeev@linux.vnet.ibm.com>, "'acme@kernel.org'"
	<acme@kernel.org>, "'jolsa@kernel.org'" <jolsa@kernel.org>,
	"'adrian.hunter@intel.com'" <adrian.hunter@intel.com>, "'irogers@google.com'"
	<irogers@google.com>, "'namhyung@kernel.org'" <namhyung@kernel.org>
CC: "'kjain@linux.ibm.com'" <kjain@linux.ibm.com>,
	"'linux-perf-users@vger.kernel.org'" <linux-perf-users@vger.kernel.org>,
	"'maddy@linux.ibm.com'" <maddy@linux.ibm.com>, "'disgoel@linux.vnet.ibm.com'"
	<disgoel@linux.vnet.ibm.com>, "'linuxppc-dev@lists.ozlabs.org'"
	<linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH 1/3] perf tests test_arm_coresight: Fix the shellcheck
 warning in latest test_arm_coresight.sh
Thread-Topic: [PATCH 1/3] perf tests test_arm_coresight: Fix the shellcheck
 warning in latest test_arm_coresight.sh
Thread-Index: AQHZ8otO1Cm02Mw9rEODc38+gtl1Z7A7ApdAgABeJuA=
Date: Thu, 5 Oct 2023 15:45:30 +0000
Message-ID: <5d79ca77e4ca4f6c895e26384655563f@AcuMS.aculab.com>
References: <20230929041133.95355-1-atrajeev@linux.vnet.ibm.com>
 <20230929041133.95355-2-atrajeev@linux.vnet.ibm.com>
 <3b7b34e74bdb4b05b6b21edd81af59d0@AcuMS.aculab.com>
In-Reply-To: <3b7b34e74bdb4b05b6b21edd81af59d0@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: David Laight
> Sent: 05 October 2023 11:16
...
> > -=09cs_etm_path=3D$(find  /sys/bus/event_source/devices/cs_etm/ -name c=
pu* -print -quit)
> > +=09cs_etm_path=3D$(find  /sys/bus/event_source/devices/cs_etm/ -name '=
cpu*' -print -quit)
>=20
> Isn't the intention to get the shell to expand "cpu* ?
> So quoting it completely breaks the script.

Complete brain-fade :-(

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

