From: Jueyuan Zhu <jueyuan.zhu@gmail.com>
Subject: How to measure VM events using perf-event
Date: Thu, 9 Apr 2015 23:46:10 -0400
Message-ID: <37CC8A17-BF41-41A5-8890-83A792C0BC08@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:36244 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753457AbbDJDqO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 9 Apr 2015 23:46:14 -0400
Received: by qku63 with SMTP id 63so12113564qku.3
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Apr 2015 20:46:13 -0700 (PDT)
Received: from nat-oitwireless-inside-vapornet100-d-15872.princeton.edu (nat-oitwireless-outside-vapornet3-c-8.Princeton.EDU. [140.180.242.20])
        by mx.google.com with ESMTPSA id d11sm726725qgd.31.2015.04.09.20.46.11
        for <linux-perf-users@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 09 Apr 2015 20:46:12 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello,

I am trying to use the perf-event to measure the events for one specifi=
ed VM in KVM platform. Since each VM is just a process in the host OS, =
so I thought we could just set the process id of this VM in the perf-ev=
ent_open API to count the events. The following is my code (based on th=
e example from perf_event_open linux manual).=20

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <sys/ioctl.h>
#include <linux/perf_event.h>
#include <asm/unistd.h>

int main(int argc, char **argv)
{
    struct perf_event_attr pe;
    long long count;
    int fd;
    int pid =3D VM_id; // the process id of the VM.

    memset(&pe, 0, sizeof(struct perf_event_attr));
    pe.size =3D sizeof(struct perf_event_attr);
    pe.type =3D PERF_TYPE_HARDWARE;
    pe.config =3D PERF_COUNT_HW_INSTRUCTIONS;
    pe.disabled =3D 1;
    pe.exclude_kernel =3D 0;
    pe.exclude_hv =3D 0;
    pe.exclude_host =3D 0;
    pe.exclude_guest =3D 0;

    fd =3D syscall(__NR_perf_event_open, &pe, pid, -1, -1, 0);
    if (fd =3D=3D -1) {
       fprintf(stderr, "Error opening leader %llx\n", pe.config);
       exit(EXIT_FAILURE);
    }

    ioctl(fd, PERF_EVENT_IOC_RESET, 0);
    ioctl(fd, PERF_EVENT_IOC_ENABLE, 0);

    sleep(1);

    ioctl(fd, PERF_EVENT_IOC_DISABLE, 0);
    read(fd, &count, sizeof(long long));

    printf("# of instructions:  %lld\n", count);

    close(fd);
}

However, this program=92s output keeps constant whenever this VM is idl=
e, or running different benchmarks. So it seems the event counting is i=
ncorrect. Can anyone tell me how to set the flags or perf_event_attr to=
 correctly count the VM events using perf_event_open?=20

Thank you very much in advance!!

Best regards,

Jueyuan--
To unsubscribe from this list: send the line "unsubscribe linux-perf-us=
ers" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
