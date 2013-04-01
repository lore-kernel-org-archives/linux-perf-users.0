From: OSDepend <osdepend-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Howto make perf probe work
Date: Mon, 1 Apr 2013 23:20:31 +0800
Message-ID: <201304012320294652937@gmail.com>
References: <201304010130139026692@gmail.com>,
	<CAGJbQddYW4-QZUvGpwCbmVhsvGEan5UkgRbXq+w4i+9Ob9vUrw@mail.gmail.com>
Reply-To: Linux Tools developer discussions <linuxtools-dev-j9T/66MeVpFAfugRpC6u6w@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4135655280669384524=="
Return-path: <linuxtools-dev-bounces-j9T/66MeVpFAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <https://dev.eclipse.org/mailman/options/linuxtools-dev>,
	<mailto:linuxtools-dev-request-j9T/66MeVpFAfugRpC6u6w@public.gmane.org?subject=unsubscribe>
List-Archive: <https://dev.eclipse.org/mailman/private/linuxtools-dev>
List-Post: <mailto:linuxtools-dev-j9T/66MeVpFAfugRpC6u6w@public.gmane.org>
List-Help: <mailto:linuxtools-dev-request-j9T/66MeVpFAfugRpC6u6w@public.gmane.org?subject=help>
List-Subscribe: <https://dev.eclipse.org/mailman/listinfo/linuxtools-dev>,
	<mailto:linuxtools-dev-request-j9T/66MeVpFAfugRpC6u6w@public.gmane.org?subject=subscribe>
Errors-To: linuxtools-dev-bounces-j9T/66MeVpFAfugRpC6u6w@public.gmane.org
Sender: linuxtools-dev-bounces-j9T/66MeVpFAfugRpC6u6w@public.gmane.org
To: nelakurthi koteswararao <koteswararao18-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-perf-users <linux-perf-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: linuxtools-dev <linuxtools-dev-j9T/66MeVpFAfugRpC6u6w@public.gmane.org>
List-Id: linux-perf-users.vger.kernel.org


This is a multi-part message in MIME format.

--===============4135655280669384524==
Content-Type: multipart/alternative;
	boundary="=====003_Dragon155122461082_====="


This is a multi-part message in MIME format.

--=====003_Dragon155122461082_=====
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

>HI,
>Please enable kprobe_event config option in the kernel and build the same
>and boot the board using it. Then please try to add event using perf probe
>command

Thanks very much for your reply, and I already enable DEBUG_KPROBE_EVENT in kernel.
I did success in "perf probe handle_mm_fault".

But when i want to to "perf probe" other Kernel symbol, such as do_page_fault.
I came across other problems:
Added new event:
Failed to write event: Invalid argument
Error: Failed to add events. (-1)
And when i type perf probe page_fault_entry:
Kernel symbol 'page_fault_entry' not found.
Error: Failed to add events. (-2)
Please notice that "do_page_fault" and "page_fault_entry" are all Kernel symbols, which canbe find in  "/proc/kallsyms", but not recorgonized by perf (or even kprobe).
Any idea for that?

Best,
Chen

>>On Sun, Mar 31, 2013 at 11:00 PM, OSDepend <osdepend-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>Hi all,
>>        Is there any way to use perf probe to add new tracepoint like pagefault enter/exit?
>>        When I type perf probe fault:10
>>       I always get the error as follow:
>>                Debuginfo-analysis is not supported.
>>                Error: Failed to add events. (-38)
>>        What exactly i miss to get the perf probe work correctly?
>>Best,
>>Chen

--=====003_Dragon155122461082_=====
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content="text/html; charset=ISO-8859-1" http-equiv=Content-Type>
<META name=GENERATOR content="MSHTML 9.00.8112.16464">
<STYLE>@font-face {
	font-family: &#23435;&#20307;;
}
@font-face {
	font-family: Verdana;
}
@font-face {
	font-family: @&#23435;&#20307;;
}
@page Section1 {size: 595.3pt 841.9pt; margin: 72.0pt 90.0pt 72.0pt 90.0pt; layout-grid: 15.6pt; }
P.MsoNormal {
	TEXT-JUSTIFY: inter-ideograph; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; FONT-FAMILY: "Times New Roman"; FONT-SIZE: 10.5pt
}
LI.MsoNormal {
	TEXT-JUSTIFY: inter-ideograph; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; FONT-FAMILY: "Times New Roman"; FONT-SIZE: 10.5pt
}
DIV.MsoNormal {
	TEXT-JUSTIFY: inter-ideograph; TEXT-ALIGN: justify; MARGIN: 0cm 0cm 0pt; FONT-FAMILY: "Times New Roman"; FONT-SIZE: 10.5pt
}
A:link {
	COLOR: blue; TEXT-DECORATION: underline
}
SPAN.MsoHyperlink {
	COLOR: blue; TEXT-DECORATION: underline
}
A:visited {
	COLOR: purple; TEXT-DECORATION: underline
}
SPAN.MsoHyperlinkFollowed {
	COLOR: purple; TEXT-DECORATION: underline
}
SPAN.EmailStyle17 {
	FONT-STYLE: normal; FONT-FAMILY: Verdana; COLOR: windowtext; FONT-WEIGHT: normal; TEXT-DECORATION: none; mso-style-type: personal-compose
}
DIV.Section1 {
	page: Section1
}
UNKNOWN {
	FONT-SIZE: 10pt
}
BLOCKQUOTE {
	MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px; MARGIN-LEFT: 2em
}
OL {
	MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px
}
UL {
	MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px
}
</STYLE>
</HEAD>
<BODY style="MARGIN: 10px; FONT-FAMILY: verdana; FONT-SIZE: 10pt">
<DIV>
<DIV>
<DIV>&gt;HI,</DIV>
<DIV></DIV>
<DIV>&gt;Please enable kprobe_event config option in the kernel and build the 
same</DIV>
<DIV>&gt;and boot the board using it. Then please try to add event using perf 
probe</DIV>
<DIV></DIV>
<DIV>&gt;command</DIV>
<DIV></DIV>
<DIV>&nbsp;</DIV></DIV>
<DIV>Thanks&nbsp;very&nbsp;much&nbsp;for&nbsp;your&nbsp;reply,&nbsp;and&nbsp;I&nbsp;already&nbsp;enable&nbsp;DEBUG_KPROBE_EVENT&nbsp;in&nbsp;kernel.</DIV>
<DIV>I&nbsp;did&nbsp;success&nbsp;in&nbsp;"perf&nbsp;probe&nbsp;handle_mm_fault".</DIV>
<DIV></DIV>
<DIV>&nbsp;</DIV>
<DIV>But&nbsp;when&nbsp;i&nbsp;want&nbsp;to&nbsp;to&nbsp;"perf&nbsp;probe"&nbsp;other&nbsp;Kernel&nbsp;symbol,&nbsp;such&nbsp;as&nbsp;do_page_fault.</DIV>
<DIV>I&nbsp;came&nbsp;across&nbsp;other&nbsp;problems:</DIV>
<DIV style="TEXT-INDENT: 2em">Added&nbsp;new&nbsp;event:</DIV>
<DIV 
style="TEXT-INDENT: 2em">Failed&nbsp;to&nbsp;write&nbsp;event:&nbsp;Invalid&nbsp;argument</DIV>
<DIV 
style="TEXT-INDENT: 2em">Error:&nbsp;Failed&nbsp;to&nbsp;add&nbsp;events.&nbsp;(-1)</DIV>
<DIV>And&nbsp;when&nbsp;i&nbsp;type&nbsp;perf&nbsp;probe&nbsp;page_fault_entry:</DIV>
<DIV 
style="TEXT-INDENT: 2em">Kernel&nbsp;symbol&nbsp;'page_fault_entry'&nbsp;not&nbsp;found.</DIV>
<DIV 
style="TEXT-INDENT: 2em">Error:&nbsp;Failed&nbsp;to&nbsp;add&nbsp;events.&nbsp;(-2)</DIV>
<DIV></DIV>
<DIV>Please&nbsp;notice&nbsp;that&nbsp;"do_page_fault"&nbsp;and&nbsp;"page_fault_entry"&nbsp;are&nbsp;all&nbsp;Kernel&nbsp;symbols,&nbsp;which&nbsp;canbe&nbsp;find&nbsp;in&nbsp;&nbsp;"/proc/kallsyms",&nbsp;but&nbsp;not&nbsp;recorgonized&nbsp;by&nbsp;perf&nbsp;(or&nbsp;even&nbsp;kprobe).</DIV>
<DIV>Any&nbsp;idea&nbsp;for&nbsp;that?</DIV>
<DIV>&nbsp;</DIV>
<DIV>Best,</DIV>
<DIV>Chen</DIV>
<DIV></DIV>
<DIV>&nbsp;</DIV>
<DIV></DIV>
<DIV></DIV>
<DIV></DIV>
<DIV></DIV>
<DIV>&gt;&gt;On&nbsp;Sun,&nbsp;Mar&nbsp;31,&nbsp;2013&nbsp;at&nbsp;11:00&nbsp;PM,&nbsp;OSDepend&nbsp;&lt;osdepend-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;&nbsp;wrote:</DIV>
<DIV></DIV>
<DIV>&gt;&gt;Hi&nbsp;all,</DIV>
<DIV>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Is&nbsp;there&nbsp;any&nbsp;way&nbsp;to&nbsp;use&nbsp;perf&nbsp;probe&nbsp;to&nbsp;add&nbsp;new&nbsp;tracepoint&nbsp;like&nbsp;pagefault&nbsp;enter/exit?</DIV>
<DIV></DIV>
<DIV>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;When&nbsp;I&nbsp;type&nbsp;perf&nbsp;probe&nbsp;fault:10</DIV>
<DIV>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I&nbsp;always&nbsp;get&nbsp;the&nbsp;error&nbsp;as&nbsp;follow:</DIV>
<DIV></DIV>
<DIV>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Debuginfo-analysis&nbsp;is&nbsp;not&nbsp;supported.</DIV>
<DIV>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Error:&nbsp;Failed&nbsp;to&nbsp;add&nbsp;events.&nbsp;(-38)</DIV>
<DIV></DIV>
<DIV>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;What&nbsp;exactly&nbsp;i&nbsp;miss&nbsp;to&nbsp;get&nbsp;the&nbsp;perf&nbsp;probe&nbsp;work&nbsp;correctly?</DIV>
<DIV></DIV>
<DIV>&gt;&gt;Best,</DIV>
<DIV>&gt;&gt;Chen</DIV>
<DIV></DIV></DIV></BODY></HTML>

--=====003_Dragon155122461082_=====--


--===============4135655280669384524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4135655280669384524==--
