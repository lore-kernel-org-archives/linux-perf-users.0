Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEED31A85
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Oct 2023 16:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kbe8WR/B"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F869C0
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Oct 2023 09:21:17 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CG9Olh010020;
	Thu, 12 Oct 2023 16:20:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=IjQp9btYVsmFNXqyWakKDxSvIesxctkCSDizI5iaJxc=;
 b=kbe8WR/BFy/pmTuZM61C+gtqaFpo2EciKK0+w5SDE7ChDwOT41R/jxUMe+q0UjHGFUYw
 r4EngTdl0puKMZ3IxswD8ut4NhQ6pj9TQC485Kn+u/q2b6ReLqiPYZwfDt5rlwAbc7lJ
 THlUSe6iC2IqXsJok31kYyRbgCYVZTe18bEqmsWIfCyk5kNaobUgRnyADKuhEGlmAX0+
 DuDMIZ79W+h568BZeJ1piE9QMqNiKj+VlJ1c9r8O/AjAbx049evqGo/RgklQ+0q8KxIJ
 Qs1mMowXfckCvJiqnk5IGvbnfIn/wdEQRhflM7qQd/CV4BgXL3MHkHLfh01B+QK13HXb gw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpm2r8mtt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Oct 2023 16:20:46 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39CG9d3h011116;
	Thu, 12 Oct 2023 16:20:46 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpm2r8mt4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Oct 2023 16:20:46 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39CEYZJj023015;
	Thu, 12 Oct 2023 16:20:45 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tkmc207vp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Oct 2023 16:20:45 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39CGKgsV19071596
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Oct 2023 16:20:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6444120043;
	Thu, 12 Oct 2023 16:20:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A77F420040;
	Thu, 12 Oct 2023 16:20:39 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.59.173])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 12 Oct 2023 16:20:39 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH 1/3] perf tests test_arm_coresight: Fix the shellcheck
 warning in latest test_arm_coresight.sh
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <2219fc04-4484-b365-1281-a5307b368ec5@arm.com>
Date: Thu, 12 Oct 2023 21:50:27 +0530
Cc: "David.Laight@aculab.com" <David.Laight@ACULAB.COM>, mike.leach@linaro.org,
        James Clark <james.clark@arm.com>, Namhyung Kim <namhyung@kernel.org>,
        tianruidong@linux.alibaba.com, Leo Yan <leo.yan@linaro.org>,
        yangtiezhu@loongson.cn, Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Disha Goel <disgoel@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C4F6149F-C5FD-44AC-818F-0A84C08F45E2@linux.vnet.ibm.com>
References: <20230929041133.95355-1-atrajeev@linux.vnet.ibm.com>
 <20230929041133.95355-2-atrajeev@linux.vnet.ibm.com>
 <CAM9d7cj26Dpit3igZjybsbnotBiv_F8mEu62Aor+9bBhwVh55g@mail.gmail.com>
 <c59c586e-08ab-df66-7bcd-5249d2481298@arm.com>
 <4C5929B2-96B3-46D5-82ED-ADD6A0CDE97B@linux.vnet.ibm.com>
 <2219fc04-4484-b365-1281-a5307b368ec5@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
X-Mailer: Apple Mail (2.3731.700.6)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QUlGt5X_RaH3lf7YKcEWbrXTeJxmM8Zp
X-Proofpoint-GUID: oGo5VE1O8SEpkrG1tF99oYGyce5QTg0j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 mlxscore=0 adultscore=0 spamscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 mlxlogscore=927
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120135
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> On 12-Oct-2023, at 9:37 PM, Suzuki K Poulose <suzuki.poulose@arm.com> =
wrote:
>=20
> Hi,
>=20
> On 12/10/2023 16:56, Athira Rajeev wrote:
>>> On 05-Oct-2023, at 3:06 PM, Suzuki K Poulose =
<suzuki.poulose@arm.com> wrote:
>>>=20
>>> On 05/10/2023 06:02, Namhyung Kim wrote:
>>>> On Thu, Sep 28, 2023 at 9:11=E2=80=AFPM Athira Rajeev
>>>> <atrajeev@linux.vnet.ibm.com> wrote:
>>>>>=20
>=20
> ...
>=20
>>> Thanks for the fix.
>>>=20
>>> Nothing to do with this patch, but I am wondering if the original =
patch
>>> is over engineered and may not be future proof.
>>>=20
>>> e.g.,
>>>=20
>>> cs_etm_dev_name() {
>>> + cs_etm_path=3D$(find  /sys/bus/event_source/devices/cs_etm/ -name =
cpu* -print -quit)
>>>=20
>>> Right there you got the device name and we can easily deduce the =
name of
>>> the "ETM" node.
>>>=20
>>> e.g,:
>>> etm=3D$(basename $(readlink cs_etm_path) | sed "s/[0-9]\+$//")
>>>=20
>>> And practically, nobody prevents an ETE mixed with an ETM on a =
"hybrid"
>>> system (hopefully, no one builds it ;-))
>>>=20
>>> Also, instead of hardcoding "ete" and "etm" prefixes from the arch =
part,
>>> we should simply use the cpu nodes from :
>>>=20
>>> /sys/bus/event_source/devices/cs_etm/
>>>=20
>>> e.g.,
>>>=20
>>> arm_cs_etm_traverse_path_test() {
>>> # Iterate for every ETM device
>>> for c in /sys/bus/event_source/devices/cs_etm/cpu*; do
>>> # Read the link to be on the safer side
>>> dev=3D`readlink $c`
>>>=20
>>> # Find the ETM device belonging to which CPU
>>> cpu=3D`cat $dev/cpu`
>>>=20
>>> # Use depth-first search (DFS) to iterate outputs
>>> arm_cs_iterate_devices $dev $cpu
>>> done;
>>> }
>>>=20
>>>=20
>>>=20
>>>> You'd better add Coresight folks on this.
>>>> Maybe this file was missing in the MAINTAINERS file.
>>>=20
>>> And the original author of the commit, that introduced the issue =
too.
>>>=20
>>> Suzuki
>> Hi All,
>> Thanks for the discussion and feedbacks.
>> This patch fixes the shellcheck warning introduced in function =
"cs_etm_dev_name". But with the changes that Suzuki suggested, we won't =
need the function "cs_etm_dev_name" since the code will use =
"/sys/bus/event_source/devices/cs_etm/" .  In that case, can I drop this =
patch for now from this series ?
>=20
> Yes, please. James will send out the proposed patch

Hi Suzuki,

Sure. Thanks!=20

Athira
>=20
> Suzuki
>=20
>=20

