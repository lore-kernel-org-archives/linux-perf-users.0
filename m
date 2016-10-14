From: Andreas Arnez <arnez@linux.vnet.ibm.com>
Subject: Re: [PATCH] s390: Add support for z13
Date: Fri, 14 Oct 2016 20:32:27 +0200
Message-ID: <m3wphabx38.fsf@oc1027705133.ibm.com>
References: <m3mvnwu1cy.fsf@oc1027705133.ibm.com>
        <bb9acd86-0c7c-7291-00c1-1c6ad8576232@redhat.com>
        <m360p8m87d.fsf@oc1027705133.ibm.com>
        <d2177055-a1c3-7562-f555-bd239836af3e@redhat.com>
        <alpine.LRH.2.20.1610042254100.6819@Diego>
        <m3vax6lkon.fsf@oc1027705133.ibm.com>
        <alpine.LRH.2.20.1610121546540.14258@Diego>
        <44aa1856-f35d-4077-df94-c588d5b3b1e2@redhat.com>
        <alpine.LRH.2.20.1610131424000.14258@Diego>
        <1cb7be99-0b62-3dab-1194-20fe3171ac44@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48212 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932279AbcJNScg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 14 Oct 2016 14:32:36 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u9EIUCWJ102706
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Oct 2016 14:32:35 -0400
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 262yy5w15w-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Oct 2016 14:32:35 -0400
Received: from localhost
        by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <arnez@linux.vnet.ibm.com>;
        Fri, 14 Oct 2016 19:32:33 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6AA6F1B08067
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Oct 2016 19:34:32 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com [9.149.37.216])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u9EIWUoS16711730
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Oct 2016 18:32:30 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u9EIWTk9013882
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Oct 2016 12:32:30 -0600
In-Reply-To: <1cb7be99-0b62-3dab-1194-20fe3171ac44@redhat.com> (William
        Cohen's message of "Thu, 13 Oct 2016 10:15:05 -0400")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: William Cohen <wcohen@redhat.com>
Cc: Michael Petlan <mpetlan@redhat.com>, Andreas Krebbel <krebbel@linux.vnet.ibm.com>, oprofile-list@lists.sf.net, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On Thu, Oct 13 2016, William Cohen wrote:

> Yes, the s390 processor detection in oprofile is not ideal with the kernel
> outputting the id in hex and the oprofile reading it in as a decimal.
> Good thing that none of the s390 id values have a-f in the digits.
> Attached is a patch that reads in the values as hex to better line up with
> the kernel's handling of the s390 identification.  Could one of the IBM
> people try this patch?

Sure.  The patch looks good to me, and I've verified it on one of the
affected machines.

--
Andreas
