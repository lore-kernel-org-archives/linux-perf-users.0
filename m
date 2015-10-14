From: "George Chochia" <chochia@us.ibm.com>
Subject: Re: unresolved function names in perf output
Date: Wed, 14 Oct 2015 17:05:39 -0400
Message-ID: <201510142113.t9ELDwOC005319@d01av02.pok.ibm.com>
References: <201510141318.t9EDIkYW025291@d01av02.pok.ibm.com>
	<561E79C4.1020907@redhat.com>
Content-Type: multipart/mixed; boundary="===============2705229824090220314=="
Return-path: <oprofile-list-bounces@lists.sourceforge.net>
In-Reply-To: <561E79C4.1020907@redhat.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/oprofile-list>,
	<mailto:oprofile-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=oprofile-list>
List-Post: <mailto:oprofile-list@lists.sourceforge.net>
List-Help: <mailto:oprofile-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/oprofile-list>,
	<mailto:oprofile-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: oprofile-list-bounces@lists.sourceforge.net
To: William Cohen <wcohen@redhat.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, oprofile-list <oprofile-list@lists.sourceforge.net>
List-Id: linux-perf-users.vger.kernel.org

--===============2705229824090220314==
Content-type: multipart/related;
	Boundary="0__=0ABBF44DDFE3D25F8f9e8a93df938690918c0ABBF44DDFE3D25F"

--0__=0ABBF44DDFE3D25F8f9e8a93df938690918c0ABBF44DDFE3D25F
Content-type: multipart/alternative;
	Boundary="1__=0ABBF44DDFE3D25F8f9e8a93df938690918c0ABBF44DDFE3D25F"


--1__=0ABBF44DDFE3D25F8f9e8a93df938690918c0ABBF44DDFE3D25F
Content-Transfer-Encoding: quoted-printable
Content-type: text/plain; charset=US-ASCII


Hi Will,

eu-readelf -s libmlx5-rdmav2.so does not show symbols encountered at run
time but gdb finds them:
Breakpoint 1, 0x0000100009510ae8 in mlx5=5Fpoll=5Fcq=5F1 ()
from /lib64/libmlx5-rdmav2.so .

The address does not match one in the perf output.

I noticed that there is a debug version of the same library installed in a
different directory on Ubuntu but not on Red Hat.
I found a version of libmlx5-rdmav2.so with debug info. No problems
resolving symbol names with it.

Regards



From:	William Cohen <wcohen@redhat.com>
To:	George Chochia/Poughkeepsie/IBM@IBMUS, oprofile-list
            <oprofile-list@lists.sourceforge.net>,
            "linux-perf-users@vger.kernel.org"
            <linux-perf-users@vger.kernel.org>
Date:	10/14/2015 11:50 AM
Subject:	Re: unresolved function names in perf output



On 10/14/2015 09:08 AM, George Chochia wrote:
> Hello,
>
> I am profiling an MPI app using perf tool on Power 8, LE node installed
with RHEL 7.2 3.10.0-316.el7.ppc64le.
> Functions from libmlx5-rdmav2.so (Mellanox library from MOFED
3.1-1.0.0.2) show up as function pointers in perf report.
>
> On the same node installed with Ubuntu 14.04.03 and same MOFED level
function names are resolved.

Hi,

It sounds like libmlx5-rdmav2.so might missing debuginfo on the RHEL7.2
version and that is why the addresses are not be mapped back to function
names.  You might try the following to see if there are symbols for that
library:

eu-readelf -s <path=5Fto=5Flibrary>

Where did you get libmlx5-rdmav2.so?  You might also check to see if there
is an associated debuginfo rpm for that package that needs to be installed.
RHEL packages typically have debug information stripped from the rpm and
placed in a separate debuginfo rpm.

-Will

> RHEL 7.2
> 19.79%spark64.Linux.L libpami.so [.] =5Fstripe=5Fhal=5Fwritepkti
> 11.89%spark64.Linux.L libhal64=5Fibm.so [.] hal=5Fibl=5Frc=5Fscq=5Fflush
> 9.07%spark64.Linux.L libhal64=5Fibm.so [.] hal=5Fibl=5Frc=5Fread=5Fcallba=
ck
> 8.40%spark64.Linux.L libpami.so [.] =5Fstripe=5Fhal=5Fread=5Fcallback
> 7.65%spark64.Linux.L libpami.so [.] =5Fstripe=5Fhal=5Fflush
> 5.83%spark64.Linux.L libhal64=5Fibm.so [.] hal=5Fibl=5Frc=5Fscq=5Fwritepk=
ti
> 4.48%spark64.Linux.L libpami.so [.] LapiImpl::Interconnect::SendPacketI
> 3.19%spark64.Linux.L libpami.so [.] Sam::Send
> 2.75%spark64.Linux.L libpami.so [.] =5Flapi=5Fdispatcher<true>
> 2.33%spark64.Linux.L libmlx5-rdmav2.so [.] 0x0000000000010b20
> 2.02%spark64.Linux.L libpami.so [.] SamSendQueue::Process
> 1.82%spark64.Linux.L libmlx5-rdmav2.so [.] 0x0000000000010b98
>
>
> Ubuntu 14.04.3
> 18.09%spark64.Linux.L libpami.so [.] =5FZ21=5Fstripe=5Fhal=5FwritepktiPvS=
=5FS=5FjS=5F
> 9.54%spark64.Linux.L libhal64=5Fibm.so [.] hal=5Fibl=5Frc=5Fscq=5Fflush
> 8.67%spark64.Linux.L libmlx5-rdmav2.so [.] mlx5=5Fpoll=5Fcq=5F1
> 8.22%spark64.Linux.L libhal64=5Fibm.so [.] hal=5Fibl=5Frc=5Fread=5Fcallba=
ck
> 7.70%spark64.Linux.L libpami.so [.]
=5FZ25=5Fstripe=5Fhal=5Fread=5FcallbackPvPFiS=5FS=5FjES=5FP11hal=5Fparam=5Ft
> 7.24%spark64.Linux.L libpami.so [.] =5FZ17=5Fstripe=5Fhal=5FflushPvS=5F
> 6.76%spark64.Linux.L libhal64=5Fibm.so [.] hal=5Fibl=5Frc=5Fscq=5Fwritepk=
ti
> 4.52%spark64.Linux.L libmlx5-rdmav2.so [.] get=5Fsw=5Fcqe
>
>
> Regards
>
>
>
---------------------------------------------------------------------------=
---

>
>
>
> =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
> oprofile-list mailing list
> oprofile-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/oprofile-list
>



--1__=0ABBF44DDFE3D25F8f9e8a93df938690918c0ABBF44DDFE3D25F
Content-Transfer-Encoding: quoted-printable
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body><p>Hi Will,<br><br><font size=3D"2" face=3D"Courier New">eu-rea=
delf -s libmlx5-rdmav2.so</font> does not show symbols encountered at run t=
ime but gdb finds them:<br><font size=3D"2" face=3D"Courier New">Breakpoint=
 1, 0x0000100009510ae8 in mlx5=5Fpoll=5Fcq=5F1 () from /lib64/libmlx5-rdmav=
2.so .</font><br><br>The address does not match one in the perf output.<br>=
 <br>I noticed that there is a debug version of the same library installed =
in a different directory on Ubuntu but not on Red Hat.<br>I found a version=
 of <font size=3D"2" face=3D"Courier New">libmlx5-rdmav2.so </font>with deb=
ug info. No problems resolving symbol names with it.<br><br>Regards<br><br>=
<img width=3D"16" height=3D"16" src=3D"cid:1=5F=5F=3D0ABBF44DDFE3D25F8f9e8a=
93df938690918c0AB@" border=3D"0" alt=3D"Inactive hide details for William C=
ohen ---10/14/2015 11:50:37 AM---On 10/14/2015 09:08 AM, George Chochia wro=
te: &gt; Hello,"><font color=3D"#424282">William Cohen ---10/14/2015 11:50:=
37 AM---On 10/14/2015 09:08 AM, George Chochia wrote: &gt; Hello,</font><br=
><br><font size=3D"2" color=3D"#5F5F5F">From:        </font><font size=3D"2=
">William Cohen &lt;wcohen@redhat.com&gt;</font><br><font size=3D"2" color=
=3D"#5F5F5F">To:        </font><font size=3D"2">George Chochia/Poughkeepsie=
/IBM@IBMUS, oprofile-list &lt;oprofile-list@lists.sourceforge.net&gt;, &quo=
t;linux-perf-users@vger.kernel.org&quot; &lt;linux-perf-users@vger.kernel.o=
rg&gt;</font><br><font size=3D"2" color=3D"#5F5F5F">Date:        </font><fo=
nt size=3D"2">10/14/2015 11:50 AM</font><br><font size=3D"2" color=3D"#5F5F=
5F">Subject:        </font><font size=3D"2">Re: unresolved function names i=
n perf output</font><br><hr width=3D"100%" size=3D"2" align=3D"left" noshad=
e style=3D"color:#8091A5; "><br><br><br><tt>On 10/14/2015 09:08 AM, George =
Chochia wrote:<br>&gt; Hello,<br>&gt; <br>&gt; I am profiling an MPI app us=
ing perf tool on Power 8, LE node installed with RHEL 7.2 3.10.0-316.el7.pp=
c64le.<br>&gt; Functions from libmlx5-rdmav2.so (Mellanox library from MOFE=
D 3.1-1.0.0.2) show up as function pointers in perf report.<br>&gt; <br>&gt=
; On the same node installed with Ubuntu 14.04.03 and same MOFED level func=
tion names are resolved.<br><br>Hi,<br><br>It sounds like libmlx5-rdmav2.so=
 might missing debuginfo on the RHEL7.2 version and that is why the address=
es are not be mapped back to function names. &nbsp;You might try the follow=
ing to see if there are symbols for that library:<br><br>eu-readelf -s &lt;=
path=5Fto=5Flibrary&gt;<br><br>Where did you get libmlx5-rdmav2.so? &nbsp;Y=
ou might also check to see if there is an associated debuginfo rpm for that=
 package that needs to be installed. RHEL packages typically have debug inf=
ormation stripped from the rpm and placed in a separate debuginfo rpm.<br><=
br>-Will<br><br>&gt; RHEL 7.2<br>&gt; 19.79%spark64.Linux.L libpami.so [.] =
=5Fstripe=5Fhal=5Fwritepkti<br>&gt; 11.89%spark64.Linux.L libhal64=5Fibm.so=
 [.] hal=5Fibl=5Frc=5Fscq=5Fflush<br>&gt; 9.07%spark64.Linux.L libhal64=5Fi=
bm.so [.] hal=5Fibl=5Frc=5Fread=5Fcallback<br>&gt; 8.40%spark64.Linux.L lib=
pami.so [.] =5Fstripe=5Fhal=5Fread=5Fcallback<br>&gt; 7.65%spark64.Linux.L =
libpami.so [.] =5Fstripe=5Fhal=5Fflush<br>&gt; 5.83%spark64.Linux.L libhal6=
4=5Fibm.so [.] hal=5Fibl=5Frc=5Fscq=5Fwritepkti<br>&gt; 4.48%spark64.Linux.=
L libpami.so [.] LapiImpl::Interconnect::SendPacketI<br>&gt; 3.19%spark64.L=
inux.L libpami.so [.] Sam::Send<br>&gt; 2.75%spark64.Linux.L libpami.so [.]=
 =5Flapi=5Fdispatcher&lt;true&gt;<br>&gt; 2.33%spark64.Linux.L libmlx5-rdma=
v2.so [.] 0x0000000000010b20<br>&gt; 2.02%spark64.Linux.L libpami.so [.] Sa=
mSendQueue::Process<br>&gt; 1.82%spark64.Linux.L libmlx5-rdmav2.so [.] 0x00=
00000000010b98<br>&gt; <br>&gt; <br>&gt; Ubuntu 14.04.3<br>&gt; 18.09%spark=
64.Linux.L libpami.so [.] =5FZ21=5Fstripe=5Fhal=5FwritepktiPvS=5FS=5FjS=5F<=
br>&gt; 9.54%spark64.Linux.L libhal64=5Fibm.so [.] hal=5Fibl=5Frc=5Fscq=5Ff=
lush<br>&gt; 8.67%spark64.Linux.L libmlx5-rdmav2.so [.] mlx5=5Fpoll=5Fcq=5F=
1<br>&gt; 8.22%spark64.Linux.L libhal64=5Fibm.so [.] hal=5Fibl=5Frc=5Fread=
=5Fcallback<br>&gt; 7.70%spark64.Linux.L libpami.so [.] =5FZ25=5Fstripe=5Fh=
al=5Fread=5FcallbackPvPFiS=5FS=5FjES=5FP11hal=5Fparam=5Ft<br>&gt; 7.24%spar=
k64.Linux.L libpami.so [.] =5FZ17=5Fstripe=5Fhal=5FflushPvS=5F<br>&gt; 6.76=
%spark64.Linux.L libhal64=5Fibm.so [.] hal=5Fibl=5Frc=5Fscq=5Fwritepkti<br>=
&gt; 4.52%spark64.Linux.L libmlx5-rdmav2.so [.] get=5Fsw=5Fcqe<br>&gt; <br>=
&gt; <br>&gt; Regards<br>&gt; <br>&gt; <br>&gt; ---------------------------=
---------------------------------------------------<br>&gt; <br>&gt; <br>&g=
t; <br>&gt; =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F<br>&gt; oprofile-list mailing list<br>&gt; oprofile-list@lists.sourcefo=
rge.net<br>&gt; </tt><tt><a href=3D"https://lists.sourceforge.net/lists/lis=
tinfo/oprofile-list">https://lists.sourceforge.net/lists/listinfo/oprofile-=
list</a></tt><tt><br>&gt; <br><br></tt><br><BR>
</body></html>

--1__=0ABBF44DDFE3D25F8f9e8a93df938690918c0ABBF44DDFE3D25F--


--0__=0ABBF44DDFE3D25F8f9e8a93df938690918c0ABBF44DDFE3D25F
Content-type: image/gif;
	name="graycol.gif"
Content-Disposition: inline; filename="graycol.gif"
Content-ID: <1__=0ABBF44DDFE3D25F8f9e8a93df938690918c0AB@>
Content-Transfer-Encoding: base64

R0lGODlhEAAQAKECAMzMzAAAAP///wAAACH5BAEAAAIALAAAAAAQABAAAAIXlI+py+0PopwxUbpu
ZRfKZ2zgSJbmSRYAIf4fT3B0aW1pemVkIGJ5IFVsZWFkIFNtYXJ0U2F2ZXIhAAA7


--0__=0ABBF44DDFE3D25F8f9e8a93df938690918c0ABBF44DDFE3D25F--



--===============2705229824090220314==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============2705229824090220314==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
oprofile-list mailing list
oprofile-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/oprofile-list

--===============2705229824090220314==--
