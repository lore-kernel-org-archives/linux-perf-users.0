From: Arnaldo Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH v4 0/8] powerpc/perf: Add json file metric support for the
 hv_24x7 socket/chip level events
Date: Mon, 09 Mar 2020 08:22:58 -0300
Message-ID: <A2F32D56-CCD0-4D5E-ACAA-710AD91635AC@gmail.com>
References: <20200309062552.29911-1-kjain@linux.ibm.com>
 <20200309093506.GB67774@krava>
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----270YK9CK95ZFO6JEK6BIIT4MHMOD1S"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
In-Reply-To: <20200309093506.GB67774@krava>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
To: Jiri Olsa <jolsa@redhat.com>, Kajol Jain <kjain@linux.ibm.com>
Cc: mark.rutland@arm.com, maddy@linux.vnet.ibm.com, peterz@infradead.org, yao.jin@linux.intel.com, mingo@kernel.org, kan.liang@linux.intel.com, ak@linux.intel.com, alexander.shishkin@linux.intel.com, anju@linux.vnet.ibm.com, mamatha4@linux.vnet.ibm.com, sukadev@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com, acme@kernel.org, jmario@redhat.com, namhyung@kernel.org, tglx@linutronix.de, mpetlan@redhat.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, jolsa@kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-perf-users.vger.kernel.org

------270YK9CK95ZFO6JEK6BIIT4MHMOD1S
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sure, will do it today

On March 9, 2020 6:35:06 AM GMT-03:00, Jiri Olsa <jolsa@redhat=2Ecom> wrot=
e:
>On Mon, Mar 09, 2020 at 11:55:44AM +0530, Kajol Jain wrote:
>> First patch of the patchset fix inconsistent results we are getting
>when
>> we run multiple 24x7 events=2E
>>=20
>> Patchset adds json file metric support for the hv_24x7 socket/chip
>level
>> events=2E "hv_24x7" pmu interface events needs system dependent
>parameter
>> like socket/chip/core=2E For example, hv_24x7 chip level events needs
>> specific chip-id to which the data is requested should be added as
>part
>> of pmu events=2E
>>=20
>> So to enable JSON file support to "hv_24x7" interface, patchset
>expose
>> total number of sockets and chips per-socket details in sysfs
>> files (sockets, chips) under "/sys/devices/hv_24x7/interface/"=2E
>>=20
>> To get sockets and number of chips per sockets, patchset adds a rtas
>call
>> with token "PROCESSOR_MODULE_INFO" to get these details=2E Patchset
>also
>> handles partition migration case to re-init these system depended
>> parameters by adding proper calls in post_mobility_fixup()
>(mobility=2Ec)=2E
>>=20
>> Patch 6 & 8 of the patchset handles perf tool plumbing needed to
>replace
>> the "?" character in the metric expression to proper value and
>hv_24x7
>> json metric file for different Socket/chip resources=2E
>>=20
>> Patch set also enable Hz/hz prinitg for --metric-only option to print
>> metric data for bus frequency=2E
>>=20
>> Applied and tested all these patches cleanly on top of jiri's flex
>changes
>> with the changes done by Kan Liang for "Support metric group
>constraint"
>> patchset and made required changes=2E
>>=20
>> Changelog:
>> v3 -> v4
>> - Made changes suggested by jiri=2E
>
>could you please mention them next time? ;-)
>
>> - Apply these patch on top of Kan liang changes=2E
>
>Arnaldo, could you please pull the expr flex changes and Kan's
>metric group constraint changes? it's both prereq of this patchset
>
>thanks,
>jirka

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
------270YK9CK95ZFO6JEK6BIIT4MHMOD1S
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body>Sure, will do it today<br><br><div class=3D"gmail_=
quote">On March 9, 2020 6:35:06 AM GMT-03:00, Jiri Olsa &lt;jolsa@redhat=2E=
com&gt; wrote:<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0p=
t 0=2E8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<pre class=3D"k9mail">On Mon, Mar 09, 2020 at 11:55:44AM +0530, Kajol Jain=
 wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 1ex 0=
=2E8ex; border-left: 1px solid #729fcf; padding-left: 1ex;">First patch of =
the patchset fix inconsistent results we are getting when<br>we run multipl=
e 24x7 events=2E<br><br>Patchset adds json file metric support for the hv_2=
4x7 socket/chip level<br>events=2E "hv_24x7" pmu interface events needs sys=
tem dependent parameter<br>like socket/chip/core=2E For example, hv_24x7 ch=
ip level events needs<br>specific chip-id to which the data is requested sh=
ould be added as part<br>of pmu events=2E<br><br>So to enable JSON file sup=
port to "hv_24x7" interface, patchset expose<br>total number of sockets and=
 chips per-socket details in sysfs<br>files (sockets, chips) under "/sys/de=
vices/hv_24x7/interface/"=2E<br><br>To get sockets and number of chips per =
sockets, patchset adds a rtas call<br>with token "PROCESSOR_MODULE_INFO" to=
 get these details=2E Patchset also<br>handles partition migration case to =
re-init these system depended<br>parameters by adding proper calls in post_=
mobility_fixup() (mobility=2Ec)=2E<br><br>Patch 6 &amp; 8 of the patchset h=
andles perf tool plumbing needed to replace<br>the "?" character in the met=
ric expression to proper value and hv_24x7<br>json metric file for differen=
t Socket/chip resources=2E<br><br>Patch set also enable Hz/hz prinitg for -=
-metric-only option to print<br>metric data for bus frequency=2E<br><br>App=
lied and tested all these patches cleanly on top of jiri's flex changes<br>=
with the changes done by Kan Liang for "Support metric group constraint"<br=
>patchset and made required changes=2E<br><br>Changelog:<br>v3 -&gt; v4<br>=
- Made changes suggested by jiri=2E<br></blockquote><br>could you please me=
ntion them next time? ;-)<br><br><blockquote class=3D"gmail_quote" style=3D=
"margin: 0pt 0pt 1ex 0=2E8ex; border-left: 1px solid #729fcf; padding-left:=
 1ex;">- Apply these patch on top of Kan liang changes=2E<br></blockquote><=
br>Arnaldo, could you please pull the expr flex changes and Kan's<br>metric=
 group constraint changes? it's both prereq of this patchset<br><br>thanks,=
<br>jirka<br><br></pre></blockquote></div><br>-- <br>Sent from my Android d=
evice with K-9 Mail=2E Please excuse my brevity=2E</body></html>
------270YK9CK95ZFO6JEK6BIIT4MHMOD1S--
